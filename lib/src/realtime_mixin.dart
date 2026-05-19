import 'dart:async';
import 'dart:convert';
import 'dart:math';
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

String _uniqueSubscriptionId() {
  final now = DateTime.now();
  final sec = (now.millisecondsSinceEpoch / 1000).floor();
  final usec = now.microsecondsSinceEpoch - (sec * 1000000);
  final base = sec.toRadixString(16) + usec.toRadixString(16).padLeft(5, '0');
  final rand = StringBuffer();
  for (var i = 0; i < 7; i++) {
    rand.write(Random().nextInt(16).toRadixString(16));
  }
  return base + rand.toString();
}

mixin RealtimeMixin {
  late ClientAuth client;
  final Map<String, RealtimeSubscription> _subscriptions = {};
  final Map<String, Map<String, dynamic>> _pendingSubscribes = {};
  Map<String, dynamic>? _pendingPresence;
  bool _appConnected = false;
  WebSocketChannel? _websok;
  String? _lastUrl;
  late WebSocketFactory getWebSocket;
  GetFallbackCookie? getFallbackCookie;
  bool _pendingSocketRebuild = false;
  int? get closeCode => _websok?.closeCode;
  bool _reconnect = true;
  int _retries = 0;
  StreamSubscription? _websocketSubscription;
  bool _creatingSocket = false;
  Timer? _heartbeatTimer;

  Future<dynamic> _closeConnection() async {
    _stopHeartbeat();
    _appConnected = false;
    await _websocketSubscription?.cancel();
    await _websok?.sink.close(status.normalClosure, 'Ending session');
    _lastUrl = null;
    _retries = 0;
    _reconnect = false;
  }

  void _startHeartbeat() {
    _stopHeartbeat();
    _heartbeatTimer = Timer.periodic(Duration(seconds: 20), (_) {
      if (_websok != null) {
        _websok!.sink.add(jsonEncode({
          "type": "ping"
        }));
      }
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  Future<void> _createSocket() async {
    final allChannels = <String>{};
    for (var subscription in _subscriptions.values) {
      allChannels.addAll(subscription.channels);
    }

    // Single-flight guard: another caller is already opening a socket.
    // Both subscribe() and upsertPresence() may land here concurrently.
    if (_creatingSocket) {
      _pendingSocketRebuild = true;
      return;
    }
    // Open the socket when either a subscription exists or a presence
    // payload is queued (presence-only usage).
    if (allChannels.isEmpty && _pendingPresence == null) return;
    _creatingSocket = true;
    final uri = _prepareUri();
    try {
      if (_websok == null || _websok?.closeCode != null) {
        _websok = await getWebSocket(uri);
        _lastUrl = uri.toString();
      } else {
        if (_lastUrl == uri.toString() && _websok?.closeCode == null) {
          _sendPendingSubscribes();
          _creatingSocket = false;
          return;
        }
        await _closeConnection();
        _lastUrl = uri.toString();
        _websok = await getWebSocket(uri);
      }
      _retries = 0;
      _websocketSubscription = _websok?.stream.listen((response) {
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
            for (var entry in _subscriptions.entries) {
              _pendingSubscribes[entry.key] = {
                'subscriptionId': entry.key,
                'channels': entry.value.channels,
                'queries': entry.value.queries,
              };
            }
            _appConnected = true;
            _sendPendingSubscribes();
            _flushPendingPresence();
            _startHeartbeat(); // Start heartbeat after successful connection
            break;
          case 'pong':
            break;
          case 'event':
            final messageData = data.data as Map<String, dynamic>;
            final message = RealtimeMessage.fromMap(messageData);
            final subscriptions = (messageData['subscriptions'] as List<dynamic>?)
                ?.map((x) => x.toString())
                .toList() ?? <String>[];

            if (subscriptions.isEmpty) {
              break;
            }

            for (var subscriptionId in subscriptions) {
              final subscription = _subscriptions[subscriptionId];
              if (subscription != null) {
                subscription.controller.add(message);
              }
            }
            break;
        }
      }, onDone: () {
        _appConnected = false;
        _stopHeartbeat();
        _retry();
      }, onError: (err, stack) {
        _appConnected = false;
        _stopHeartbeat();
        for (var subscription in _subscriptions.values) {
          subscription.controller.addError(err, stack);
        }
        _retry();
      });
    } catch (e) {
      if (e is AppwriteException) {
        rethrow;
      }
      debugPrint(e.toString());
      _retry();
    } finally {
      _creatingSocket = false;
      if (_pendingSocketRebuild) {
        _pendingSocketRebuild = false;
        Future.microtask(_createSocket);
      }
    }
  }

  void _retry() async {
    if (!_reconnect || _websok?.closeCode == status.policyViolation) {
      _reconnect = true;
      return;
    }
    _retries++;
    debugPrint("Reconnecting in ${_getTimeout()} seconds.");
    Future.delayed(Duration(seconds: _getTimeout()), _createSocket);
  }

  int _getTimeout() {
    return _retries < 5
        ? 1
        : _retries < 15
            ? 5
            : _retries < 100
                ? 10
                : 60;
  }

  Uri _prepareUri() {
    if (client.endPointRealtime == null) {
      throw AppwriteException(
          "Please set endPointRealtime to connect to realtime server");
    }
    var uri = Uri.parse(client.endPointRealtime!);
    
    var queryParams = "project=${Uri.encodeComponent(client.config['project']!)}";

    final portPart = (uri.hasPort && uri.port != 80 && uri.port != 443)
        ? ':${uri.port}'
        : '';
    return Uri.parse("${uri.scheme}://${uri.host}$portPart${uri.path}/realtime?$queryParams");
  }

  void _sendUnsubscribeMessage(List<String> subscriptionIds) {
    if (subscriptionIds.isEmpty) {
      return;
    }
    if (_websok == null || _websok?.closeCode != null) {
      return;
    }
    _websok!.sink.add(jsonEncode({
      'type': 'unsubscribe',
      'data': subscriptionIds.map((id) => {'subscriptionId': id}).toList(),
    }));
  }

  String _generateUniqueSubscriptionId() {
    final attempts = _subscriptions.length + 1;
    for (var i = 0; i < attempts; i++) {
      final id = _uniqueSubscriptionId();
      if (!_subscriptions.containsKey(id)) {
        return id;
      }
    }
    throw AppwriteException('Failed to generate unique subscription id');
  }

  void _enqueuePendingSubscribe(String subscriptionId) {
    final subscription = _subscriptions[subscriptionId];
    if (subscription == null) {
      return;
    }
    _pendingSubscribes[subscriptionId] = {
      'subscriptionId': subscriptionId,
      'channels': List<String>.from(subscription.channels),
      'queries': List<String>.from(subscription.queries),
    };
  }

  /// Close the WebSocket connection and drop all active subscriptions client-side.
  /// Use this instead of calling [RealtimeSubscription.unsubscribe] on every subscription
  /// when you want to tear everything down.
  Future<void> disconnect() async {
    for (var subscription in _subscriptions.values) {
      await subscription.controller.close();
    }
    _subscriptions.clear();
    _pendingSubscribes.clear();
    _pendingPresence = null;
    await _closeConnection();
    _reconnect = true; // allow future subscribeTo() calls to reconnect
  }

  void _sendPendingSubscribes() {
    if (_websok == null || _websok?.closeCode != null) {
      return;
    }
    // The WebSocket transitions to "open" before the server has emitted
    // its application-level `connected` event. Sending a subscribe frame
    // in that window triggers a policy-violation close on real Appwrite,
    // which reconnects and re-sends, looping forever. The `connected`
    // branch in _createSocket re-enqueues every active subscription and
    // re-calls this method once `_appConnected` flips true, so the queued
    // rows are guaranteed to go out — just deferred.
    if (!_appConnected) {
      return;
    }

    if (_pendingSubscribes.isEmpty) {
      return;
    }

    final rows = _pendingSubscribes.values.toList();
    _pendingSubscribes.clear();

    _websok!.sink.add(jsonEncode({
      'type': 'subscribe',
      'data': rows,
    }));
  }

  void _flushPendingPresence() {
    final data = _pendingPresence;
    if (data == null) return;
    if (_websok == null || _websok?.closeCode != null) return;
    if (!_appConnected) return;
    _websok!.sink.add(jsonEncode({'type': 'presence', 'data': data}));
  }

  /// Convert channel value to string
  /// Handles String and Channel instances (which have toString())
  String _channelToString(Object channel) {
    return channel is String ? channel : channel.toString();
  }

  RealtimeSubscription subscribeTo(List<Object> channels, [List<String> queries = const []]) {
    StreamController<RealtimeMessage> controller = StreamController.broadcast();
    final channelStrings = channels.map((ch) => _channelToString(ch)).toList().cast<String>();
    final queryStrings = List<String>.from(queries);

    final subscriptionId = _generateUniqueSubscriptionId();

    late RealtimeSubscription subscription;

    Future<void> unsubscribe() async {
      if (!_subscriptions.containsKey(subscriptionId)) {
        return;
      }
      _subscriptions.remove(subscriptionId);
      _pendingSubscribes.remove(subscriptionId);
      await controller.close();
      _sendUnsubscribeMessage([subscriptionId]);
    }

    Future<void> update(
        {List<Object>? channels, List<String>? queries}) async {
      final current = _subscriptions[subscriptionId];
      if (current == null) {
        return;
      }
      if (channels != null) {
        final nextChannels =
            channels.map((ch) => _channelToString(ch)).toList().cast<String>();
        current.channels
          ..clear()
          ..addAll(nextChannels);
      }
      if (queries != null) {
        current.queries
          ..clear()
          ..addAll(queries);
      }
      _enqueuePendingSubscribe(subscriptionId);
      if (_websok != null && _websok?.closeCode == null) {
        await Future.delayed(Duration.zero, _sendPendingSubscribes);
      } else {
        await Future.delayed(Duration.zero, () => _createSocket());
      }
    }

    Future<void> close() async {
      await unsubscribe();
      if (_subscriptions.isEmpty) {
        await _closeConnection();
      }
    }

    subscription = RealtimeSubscription(
      controller: controller,
      channels: channelStrings,
      queries: queryStrings,
      unsubscribe: unsubscribe,
      update: update,
      close: close,
    );
    _subscriptions[subscriptionId] = subscription;
    _enqueuePendingSubscribe(subscriptionId);

    Future.delayed(Duration.zero, () => _createSocket());
    return subscription;
  }

  void handleError(RealtimeResponse response) {
    if (response.data['code'] == status.policyViolation) {
      throw AppwriteException(response.data["message"], response.data["code"]);
    } else {
      _retry();
    }
  }

  /// Fire-and-forget presence upsert. Records the latest payload in state so
  /// that — if the WebSocket isn't open yet, or later reconnects — the most
  /// recent presence is automatically (re)sent on the next `connected` event.
  /// When the socket is already open, the frame is sent immediately.
  void upsertPresenceTo({
    required String status,
    required String presenceId,
    List<String>? permissions,
    Map<String, dynamic>? metadata,
  }) {
    final data = <String, dynamic>{
      'status': status,
      'presenceId': presenceId,
    };
    if (permissions != null) data['permissions'] = permissions;
    if (metadata != null) data['metadata'] = metadata;

    _pendingPresence = data;

    // Both subscribe() and upsertPresence() may need to open the socket.
    // _createSocket() is single-flight (see `_creatingSocket`), so calling
    // it here is a no-op when one is already in flight or healthy.
    if (_websok == null || _websok?.closeCode != null) {
      // Fire-and-forget; keeps upsertPresence's documented void return.
      _createSocket();
    }

    // Opportunistic send for when the socket is already past `connected`.
    // The _appConnected gate inside _flushPendingPresence keeps this a no-op
    // until the application-level handshake completes.
    _flushPendingPresence();
  }
}
