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
  // Slot-centric state: Map<slot, RealtimeSubscription>
  // Each subscription stores its own channels and queries
  final Map<int, RealtimeSubscription> _subscriptions = {};
  // Map slot index -> subscriptionId (from backend)
  final Map<int, String> _slotToSubscriptionId = {};
  // Inverse map: subscriptionId -> slot index (for O(1) lookup)
  final Map<String, int> _subscriptionIdToSlot = {};
  final List<int> _pendingSubscribeSlots = [];
  int _subscriptionsCounter = 0;
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
    // Rebuild channels from all slots
    final allChannels = <String>{};
    for (var subscription in _subscriptions.values) {
      allChannels.addAll(subscription.channels);
    }
    
    if (_creatingSocket) {
      _pendingSocketRebuild = true;
      return;
    }
    if (allChannels.isEmpty) return;
    _creatingSocket = true;
    final uri = _prepareUri();
    try {
      if (_websok == null || _websok?.closeCode != null) {
        _websok = await getWebSocket(uri);
        _lastUrl = uri.toString();
      } else {
        if (_lastUrl == uri.toString() && _websok?.closeCode == null) {
          _sendSubscribeMessage();
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
            // channels, user, subscriptions?
            final message = RealtimeResponseConnected.fromMap(data.data);
            
            // Store subscription ID mappings from backend
            // Format: { "0": "sub_a1f9", "1": "sub_b83c", ... }.
            // Try direct slot first, then slot+1 for zero-based server maps.
            final rawSubscriptions = data.data['subscriptions'];
            if (rawSubscriptions is Map) {
              rawSubscriptions.forEach((slotStr, subscriptionId) {
                final slot = int.tryParse(slotStr.toString());
                if (slot != null) {
                  final directSlotExists = _subscriptions.containsKey(slot);
                  final shiftedSlot = slot + 1;
                  final shiftedSlotExists = _subscriptions.containsKey(shiftedSlot);
                  final targetSlot = directSlotExists
                      ? slot
                      : shiftedSlotExists
                          ? shiftedSlot
                          : slot;
                  _slotToSubscriptionId[targetSlot] = subscriptionId.toString();
                  _subscriptionIdToSlot[subscriptionId.toString()] = targetSlot;
                }
              });
            }
            
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
            _sendSubscribeMessage();
            _startHeartbeat(); // Start heartbeat after successful connection
            break;
          case 'response':
            final actionData = data.data as Map<String, dynamic>;
            if (actionData['to'] != 'subscribe') {
              break;
            }
            final subscriptions = actionData['subscriptions'] as List<dynamic>?;
            if (subscriptions == null) {
              break;
            }
            for (var index = 0; index < subscriptions.length; index++) {
              final slot = index < _pendingSubscribeSlots.length ? _pendingSubscribeSlots[index] : null;
              final item = subscriptions[index] as Map<String, dynamic>?;
              final subscriptionId = item?['subscriptionId']?.toString();
              if (slot == null || subscriptionId == null || subscriptionId.isEmpty) {
                continue;
              }
              _slotToSubscriptionId[slot] = subscriptionId;
              _subscriptionIdToSlot[subscriptionId] = slot;
            }
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

            // Iterate over all matching subscriptionIds and call callback for each
            for (var subscriptionId in subscriptions) {
              // O(1) lookup using subscriptionId
              final slot = _subscriptionIdToSlot[subscriptionId];
              if (slot != null) {
                final subscription = _subscriptions[slot];
                if (subscription != null) {
                  subscription.controller.add(message);
                }
              }
            }
            break;
        }
      }, onDone: () {
        _stopHeartbeat();
        _retry();
      }, onError: (err, stack) {
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

  void _sendSubscribeMessage() {
    if (_websok == null || _websok?.closeCode != null) {
      return;
    }

    final rows = <Map<String, dynamic>>[];
    _pendingSubscribeSlots.clear();

    for (var entry in _subscriptions.entries) {
      final slot = entry.key;
      final subscription = entry.value;
      final queries = subscription.queries;
      final row = <String, dynamic>{
        'channels': subscription.channels,
        'queries': queries,
      };
      final knownSubscriptionId = _slotToSubscriptionId[slot];
      if (knownSubscriptionId != null && knownSubscriptionId.isNotEmpty) {
        row['subscriptionId'] = knownSubscriptionId;
      }
      rows.add(row);
      _pendingSubscribeSlots.add(slot);
    }

    if (rows.isEmpty) {
      return;
    }

    _websok!.sink.add(jsonEncode({
      'type': 'subscribe',
      'data': rows,
    }));
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

    // Allocate a new slot index
    _subscriptionsCounter++;
    final slot = _subscriptionsCounter;

    // Store slot-centric data: channels, queries, and callback belong to the slot
    // queries is stored as List<String> (array of query strings)
    // No channel mutation occurs here - channels are derived from slots in _createSocket()
    RealtimeSubscription subscription = RealtimeSubscription(
        controller: controller,
        channels: channelStrings,
        queries: queryStrings,
        close: () async {
          final subscriptionId = _slotToSubscriptionId[slot];
          _subscriptions.remove(slot);
          _slotToSubscriptionId.remove(slot);
          if (subscriptionId != null) {
            _subscriptionIdToSlot.remove(subscriptionId);
          }
          controller.close();

          if (_subscriptions.isNotEmpty) {
            if (_websok != null && _websok?.closeCode == null) {
              _sendSubscribeMessage();
            } else {
              await Future.delayed(Duration.zero, () => _createSocket());
            }
          } else {
            await _closeConnection();
          }
        });
    _subscriptions[slot] = subscription;
    
    Future.delayed(Duration.zero, () => _createSocket());
    return subscription;
  }

  // _cleanup is no longer needed - slots are removed directly in subscribeTo().close()
  // Channels are automatically rebuilt from remaining slots in _createSocket()

  void handleError(RealtimeResponse response) {
    if (response.data['code'] == status.policyViolation) {
      throw AppwriteException(response.data["message"], response.data["code"]);
    } else {
      _retry();
    }
  }
}