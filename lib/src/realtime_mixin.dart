import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'exception.dart';
import 'realtime_subscription.dart';
import 'client.dart';
import 'realtime_message.dart';
import 'realtime_response.dart';
import 'realtime_response_connected.dart';

typedef WebSocketFactory = Future<WebSocketChannel> Function(Uri uri);
typedef GetFallbackCookie = String? Function();

mixin RealtimeMixin {
  late Client client;
  final Set<String> _channels = {};
  WebSocketChannel? _websok;
  String? _lastUrl;
  late WebSocketFactory getWebSocket;
  GetFallbackCookie? getFallbackCookie;
  int? get closeCode => _websok?.closeCode;
  Map<int, RealtimeSubscription> _subscriptions = {};
  bool _notifyDone = true;
  StreamSubscription? _websocketSubscription;
  bool _creatingSocket = false;

  Future<dynamic> _closeConnection() async {
    await _websocketSubscription?.cancel();
    await _websok?.sink.close(status.normalClosure, 'Ending session');
    _lastUrl = null;
  }

  _createSocket() async {
    if(_creatingSocket || _channels.isEmpty) return;
    _creatingSocket = true;
    final uri = _prepareUri();
    if (_websok == null) {
      _websok = await getWebSocket(uri);
      _lastUrl = uri.toString();
    } else {
      if (_lastUrl == uri.toString() && _websok?.closeCode == null) {
        _creatingSocket = false;
        return;
      }
      _notifyDone = false;
      await _closeConnection();
      _lastUrl = uri.toString();
      _websok = await getWebSocket(uri);
      _notifyDone = true;
    }
    debugPrint('subscription: $_lastUrl');

    try {
      _websocketSubscription = _websok?.stream.listen((response) {
        final data = RealtimeResponse.fromJson(response);
        switch (data.type) {
          case 'error':
            handleError(data);
            break;
          case 'connected':
            // channels, user?
            final message = RealtimeResponseConnected.fromMap(data.data);
            if (message.user.isEmpty) {
              // send fallback cookie if exists
              final cookie = getFallbackCookie?.call();
              if (cookie != null) {
                _websok?.sink.add(jsonEncode({
                  "type": "authentication",
                  "data": {
                    "session": cookie,
                  },
                }));
              }
            }
            break;
          case 'event':
            final message = RealtimeMessage.fromMap(data.data);
            for (var subscription in _subscriptions.values) {
              for (var channel in message.channels) {
                if (subscription.channels.contains(channel)) {
                  subscription.controller.add(message);
                }
              }
            }
            break;
        }
      }, onDone: () {
        if (!_notifyDone || _creatingSocket) return;
        for (var subscription in _subscriptions.values) {
          subscription.close();
        }
        _channels.clear();
        _closeConnection();
      }, onError: (err, stack) {
        for (var subscription in _subscriptions.values) {
          subscription.controller.addError(err, stack);
        }
        if (_websok?.closeCode != null && _websok?.closeCode != 1008) {
          debugPrint("Reconnecting in one second.");
          Future.delayed(Duration(seconds: 1), _createSocket);
        }
      });
    } catch (e) {
      if (e is AppwriteException) {
        rethrow;
      }
      if (e is WebSocketChannelException) {
        throw AppwriteException(e.message);
      }
      throw AppwriteException(e.toString());
    } finally {
      _creatingSocket = false;
    }
  }

  Uri _prepareUri() {
    if (client.endPointRealtime == null) {
      throw AppwriteException(
          "Please set endPointRealtime to connect to realtime server");
    }
    var uri = Uri.parse(client.endPointRealtime!);
    return Uri(
      host: uri.host,
      scheme: uri.scheme,
      port: uri.port,
      queryParameters: {
        "project": client.config['project'],
        "channels[]": _channels.toList(),
      },
      path: uri.path + "/realtime",
    );
  }

  RealtimeSubscription subscribeTo(List<String> channels) {
    StreamController<RealtimeMessage> controller = StreamController.broadcast();
    _channels.addAll(channels);
    Future.delayed(Duration.zero, () => _createSocket());
    int id = DateTime.now().microsecondsSinceEpoch;
    RealtimeSubscription subscription = RealtimeSubscription(
        controller: controller,
        channels: channels,
        close: () async {
          _subscriptions.remove(id);
          controller.close();
          _cleanup(channels);

          if (_channels.isNotEmpty) {
            await Future.delayed(Duration.zero, () => _createSocket());
          } else {
            await _closeConnection();
          }
        });
    _subscriptions[id] = subscription;
    return subscription;
  }

  void _cleanup(List<String> channels) {
    for (var channel in channels) {
      bool found = _subscriptions.values
          .any((subscription) => subscription.channels.contains(channel));
      if (!found) {
        _channels.remove(channel);
      }
    }
  }

  void handleError(RealtimeResponse response) {
    if (response.data['code'] == 1008) {
      throw AppwriteException(response.data["message"], response.data["code"]);
    } else {
      debugPrint("Reconnecting in one second.");
      Future.delayed(const Duration(seconds: 1), () {
        _createSocket();
      });
    }
  }
}
