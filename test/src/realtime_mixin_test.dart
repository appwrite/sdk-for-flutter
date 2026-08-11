import 'dart:async';
import 'dart:convert';

import 'package:appwrite/src/client.dart';
import 'package:appwrite/src/exception.dart';
import 'package:appwrite/src/realtime_mixin.dart';
import 'package:appwrite/src/realtime_subscription.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class FakeClient implements Client {
  @override
  Map<String, String> config = {'project': 'testProject'};

  @override
  String? get endPointRealtime => 'wss://demo.appwrite.io/v1';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeWebSocketSink implements WebSocketSink {
  final List<dynamic> sent = [];
  bool closed = false;
  int? closeCode;

  @override
  void add(dynamic data) => sent.add(data);

  @override
  Future close([int? closeCode, String? closeReason]) async {
    closed = true;
    this.closeCode = closeCode;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeWebSocketChannel implements WebSocketChannel {
  final StreamController<dynamic> _controller =
      StreamController<dynamic>.broadcast();

  @override
  final FakeWebSocketSink sink = FakeWebSocketSink();

  int? _closeCode;

  @override
  Stream<dynamic> get stream => _controller.stream;

  @override
  int? get closeCode => _closeCode;

  @override
  String? get closeReason => null;

  @override
  String? get protocol => null;

  @override
  Future<void> get ready => Future.value();

  /// Simulate a frame sent by the server.
  void emit(Map<String, dynamic> message) =>
      _controller.add(jsonEncode(message));

  /// Simulate the connection dropping. [code] is null when the socket dies
  /// without a close frame reaching the client (e.g. a proxy/tunnel timeout).
  void dropConnection({int? code}) {
    _closeCode = code;
    _controller.close();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TestRealtime with RealtimeMixin {
  TestRealtime(Client client, WebSocketFactory factory) {
    this.client = client;
    getWebSocket = factory;
  }

  RealtimeSubscription subscribe(List<Object> channels) =>
      subscribeTo(channels);
}

void main() {
  group('RealtimeMixin policy violation (1008)', () {
    late List<FakeWebSocketChannel> channels;
    late TestRealtime realtime;

    setUp(() {
      channels = [];
      realtime = TestRealtime(FakeClient(), (uri) async {
        final channel = FakeWebSocketChannel();
        channels.add(channel);
        return channel;
      });
    });

    test(
        'delivers the exception to subscribers and stops reconnecting when the '
        'server rejects the connection', () async {
      final errors = <Object>[];
      final subscription = realtime.subscribe(['tables']);
      subscription.stream.listen((_) {}, onError: errors.add);

      // Let the socket open and register its listener.
      await Future.delayed(Duration(milliseconds: 50));
      expect(channels, hasLength(1));

      // The server rejects the connection at the application level, then the
      // socket dies without the 1008 close code reaching the client — this is
      // what happens behind a tunnel/proxy that drops the connection itself.
      channels.first.emit({
        'type': 'error',
        'data': {'code': 1008, 'message': 'Server Error'},
      });
      await Future.delayed(Duration(milliseconds: 50));

      // The exception must reach application code instead of being thrown as
      // an uncatchable async error inside the WebSocket stream listener.
      expect(errors, hasLength(1));
      expect(errors.single, isA<AppwriteException>());
      expect((errors.single as AppwriteException).code, 1008);

      // The dead socket must be torn down.
      expect(channels.first.sink.closed, isTrue);

      channels.first.dropConnection();

      // Retrying would be rejected the same way, so no reconnect must be
      // scheduled — previously the client hammered the server once a second.
      await Future.delayed(Duration(milliseconds: 1500));
      expect(channels, hasLength(1));

      // Once the application has reacted to the error (e.g. re-authenticated),
      // subscribing again must open a fresh socket rather than reusing the
      // rejected one, whose close has not completed yet.
      realtime.subscribe(['tables']);
      await Future.delayed(Duration(milliseconds: 50));
      expect(channels, hasLength(2));
    });

    test('still reconnects after a recoverable error', () async {
      realtime.subscribe(['tables']);
      await Future.delayed(Duration(milliseconds: 50));
      expect(channels, hasLength(1));

      channels.first.emit({
        'type': 'error',
        'data': {'code': 1011, 'message': 'Server Error'},
      });
      channels.first.dropConnection(code: 1011);

      await Future.delayed(Duration(milliseconds: 1500));
      expect(channels, hasLength(2));
    }, timeout: Timeout(Duration(seconds: 30)));
  });
}
