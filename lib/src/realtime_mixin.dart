import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/status.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'client.dart';
import 'exception.dart';
import 'realtime_message.dart';
import 'realtime_response.dart';
import 'realtime_response_connected.dart';
import 'realtime_subscription.dart';

typedef WebSocketFactory = Future<WebSocketChannel> Function(Uri uri);
typedef GetFallbackCookie = String? Function();

mixin RealtimeMixin {
  late Client client;
  final Map<String, List<StreamController<RealtimeMessage>>> _channels = {};
  WebSocketChannel? _websok;
  StreamSubscription? _websokSubscription;
  String? _lastUrl;
  late WebSocketFactory getWebSocket;
  GetFallbackCookie? getFallbackCookie;
  int? get closeCode => _websok?.closeCode;

  Future<RealtimeSubscription> subscribeTo(List<String> channels) async {
    // Add our controller to channels
    await _closeSocket();
    StreamController<RealtimeMessage> controller = StreamController.broadcast();
    for (var channel in channels) {
      if (!_channels.containsKey(channel)) {
        _channels[channel] = [];
      }
      _channels[channel]!.add(controller);
    }
    await _resetSocket();

    return RealtimeSubscription(
      stream: controller.stream,
      close: () async {
        // Unsubscribe controller to channels
        await controller.close();
        for (var channel in channels) {
          if (_channels.containsKey(channel)) {
            _channels[channel]!.remove(controller);
            if (_channels[channel]!.isEmpty) {
              _channels.remove(channel);
            }
          }
        }
        await _resetSocket();
      },
    );
  }

  void handleError(RealtimeResponse response) {
    if (response.data['code'] == 1008) {
      throw AppwriteException(response.data["message"], response.data["code"]);
    } else {
      debugPrint("Reconnecting in one second.");
      Future.delayed(const Duration(seconds: 1), () {
        _resetSocket();
      });
    }
  }

  /// Can be called anytime
  Future<void> _resetSocket([WebSocketChannel? websok]) async {
    // Listen to websocket messages
    // Auth
    // Propagte error
    // If socket is done, unsubscribe cosumers

    final socketIsNew = await _buildSocket();
    if (socketIsNew)
      try {
        _websokSubscription = _websok?.stream.listen((response) {
          final data = RealtimeResponse.fromJson(response);
          switch (data.type) {
            case 'error':
              handleError(data);
              break;
            case 'connected':
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
              for (var channel in message.channels) {
                if (_channels[channel] != null) {
                  for (var controller in _channels[channel]!) {
                    controller.sink.add(message);
                  }
                }
              }
              break;
          }
        }, onDone: () async {
          // ATM we don't understand when this method is actually called
          // We observer that it might happen asynchronously and close
          // controllers that we want to keep active.
          // Current solution is to comment it as close() of RealtimeSubscription
          // should do the job
          // for (var list in _channels.values) {
          //   for (var controller in list) {
          //     await controller.close();
          //   }
          // }
          // _channels.clear();
        }, onError: (err, stack) {
          for (var list in _channels.values) {
            for (var stream in list) {
              stream.sink.addError(err, stack);
            }
          }
          if (_websok?.closeCode != null && _websok?.closeCode != 1008) {
            debugPrint("Reconnecting in one second.");
            Future.delayed(Duration(seconds: 1), _resetSocket);
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

  Future<dynamic> _closeSocket() async {
    await _websokSubscription?.cancel();
    await _websok?.sink.close(normalClosure);
    _websok = null;
    _lastUrl = null;
  }

  // Returns true if socket has been created, false if exising socket is enough
  Future<bool> _buildSocket() async {
    // If channels have changed or socket is closed/errored => recreate socket
    final uri = this._socketUri;
    if (_websok == null) {
      _websok = await getWebSocket(uri);
      _lastUrl = uri.toString();
      return true;
    } else {
      if (_lastUrl == uri.toString() && _websok?.closeCode == null) {
        return false;
      }
      await _closeSocket();
      _websok = await getWebSocket(uri);
      _lastUrl = uri.toString();
      return true;
    }
  }

  Uri get _socketUri {
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
}
