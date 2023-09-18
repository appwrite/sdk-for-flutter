import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
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
  int? get closeCode => _websok?.closeCode;

  Future<dynamic> _closeConnection() async {
    await _websok?.sink.close(normalClosure);
    _lastUrl = null;
  }

  _createSocket() async {
    final uri = _prepareUri();
    if (_websok == null) {
      _websok = await getWebSocket(uri);
      _lastUrl = uri.toString();
    } else {
      if (_lastUrl == uri.toString() && _websok?.closeCode == null) {
        return;
      }
      await _closeConnection();
      _lastUrl = uri.toString();
      _websok = await getWebSocket(uri);
    }
    debugPrint('subscription: $_lastUrl');

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
            for(var channel in message.channels) {
              if (_channels[channel] != null) {
                for( var stream in _channels[channel]!) {
                  stream.sink.add(message);
                }
              }
            }
            break;
        }
      }, onDone: () {
        for (var list in _channels.values) {
          for (var stream in list) {
            stream.close();
          }
        }
        _channels.clear();
        _closeConnection();
      }, onError: (err, stack) {
        for (var list in _channels.values) {
          for (var stream in list) {
            stream.sink.addError(err, stack);
          }
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
    for(var channel in channels) {
      if (!_channels.containsKey(channel)) {
        _channels[channel] = [];
      }
      _channels[channel]!.add(controller);
    }
    Future.delayed(Duration.zero, () => _createSocket());
    RealtimeSubscription subscription = RealtimeSubscription(
        stream: controller.stream,
        close: () async {
          controller.close();
          for(var channel in channels) {
            if (_channels.containsKey(channel)) {
              _channels[channel]!.remove(controller);
              if (_channels[channel]!.isEmpty) {
                _channels.remove(channel);
              }
            }
          }
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
      debugPrint("Reconnecting in one second.");
      Future.delayed(const Duration(seconds: 1), () {
        _createSocket();
      });
    }
  }
}
