import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart';
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
  final Map<String, List<StreamController<RealtimeMessage>>> _channels = {};
  WebSocketChannel? _websok;
  String? _lastUrl;
  late WebSocketFactory getWebSocket;
  GetFallbackCookie? getFallbackCookie;

  Future<dynamic> _closeConnection() async {
    await _websok?.sink.close(normalClosure);
    _lastUrl = null;
  }

  _createSocket() async {
    final uri = _prepareUri();
    if (_websok == null) {
      await getWebSocket(uri);
    }
    if (_lastUrl == uri.toString() && _websok?.closeCode == null) {
      return;
    }
    await _closeConnection();
    _lastUrl = uri.toString();
    print('subscription: $_lastUrl');
    _websok = await getWebSocket(uri);

    try {
      _websok?.stream.listen((response) {
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
            message.channels.forEach((channel) {
              if (_channels[channel] != null) {
                _channels[channel]!.forEach((stream) {
                  stream.sink.add(message);
                });
              }
            });
            break;
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
        "channels[]": _channels.keys.toList(),
      },
      path: uri.path + "/realtime",
    );
  }

  RealtimeSubscription subscribeTo(List<String> channels) {
    StreamController<RealtimeMessage> controller = StreamController.broadcast();
    channels.forEach((channel) {
      if (!_channels.containsKey(channel)) {
        _channels[channel] = [];
      }
      _channels[channel]!.add(controller);
    });
    Future.delayed(Duration.zero, () => _createSocket());
    RealtimeSubscription subscription = RealtimeSubscription(
        stream: controller.stream,
        close: () async {
          controller.close();
          channels.forEach((channel) {
            _channels[channel]!.remove(controller);
            if (_channels[channel]!.isEmpty) {
              _channels.remove(channel);
            }
          });
          if(_channels.isNotEmpty) {
            await Future.delayed(Duration.zero, () => _createSocket());
          } else {
            await _closeConnection();
          }
        });
    return subscription;
  }

  void handleError(RealtimeResponse response) {
    if (response.data['code'] == 1008) {
      throw AppwriteException(response.data["message"], response.data["code"]);
    } else {
      print("Reconnecting in one second.");
      Future.delayed(Duration(seconds: 1), () {
        _createSocket();
      });
    }
  }
}
