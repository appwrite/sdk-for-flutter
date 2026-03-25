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
            // Format: { "0": "sub_a1f9", "1": "sub_b83c", ... }
            _slotToSubscriptionId.clear();
            _subscriptionIdToSlot.clear();
            if (data.data['subscriptions'] != null) {
              final subscriptions = data.data['subscriptions'] as Map<String, dynamic>;
              subscriptions.forEach((slotStr, subscriptionId) {
                final slot = int.tryParse(slotStr);
                if (slot != null) {
                  _slotToSubscriptionId[slot] = subscriptionId.toString();
                  _subscriptionIdToSlot[subscriptionId.toString()] = slot;
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
            _startHeartbeat(); // Start heartbeat after successful connection
            break;
          case 'pong':
            debugPrint('Received heartbeat response from realtime server');
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
    
    // Collect all unique channels from all slots
    final allChannels = <String>{};
    for (var subscription in _subscriptions.values) {
      allChannels.addAll(subscription.channels);
    }
    
    // Build query string from slots → channels → queries
    // Format: channel[slot][]=query (each query sent as separate parameter)
    // For each slot, repeat its queries under each channel it subscribes to
    // Example: slot 1 → channels [tests, prod], queries [q1, q2]
    //   Produces: tests[1][]=q1&tests[1][]=q2&prod[1][]=q1&prod[1][]=q2
    var queryParams = "project=${Uri.encodeComponent(client.config['project']!)}";
    
    for (var channel in allChannels) {
      final encodedChannel = Uri.encodeComponent(channel);
      queryParams += "&channels[]=$encodedChannel";
    }

    // Hardcode the select query string since Query is not accessible in this mixin
    // This is equivalent to Query.select(["*"]) which returns: {"method":"select","values":["*"]}
    final selectAllQuery = '{"method":"select","values":["*"]}';
    for (var entry in _subscriptions.entries) {
      final slot = entry.key;
      final subscription = entry.value;
      
      // Get queries array - each query is a separate string
      final queries = subscription.queries.isEmpty ? [selectAllQuery] : subscription.queries;
      
      // Repeat this slot's queries under each channel it subscribes to
      // Each query is sent as a separate parameter: channel[slot][]=q1&channel[slot][]=q2
      for (var channel in subscription.channels) {
        final encodedChannel = Uri.encodeComponent(channel);
        for (var query in queries) {
          final encodedQuery = Uri.encodeComponent(query);
          queryParams += "&$encodedChannel[$slot][]=$encodedQuery";
        }
      }
    }

    final portPart = (uri.hasPort && uri.port != 80 && uri.port != 443)
        ? ':${uri.port}'
        : '';
    return Uri.parse("${uri.scheme}://${uri.host}$portPart${uri.path}/realtime?$queryParams");
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

          // Rebuild channels from remaining slots
          final remainingChannels = <String>{};
          for (var sub in _subscriptions.values) {
            remainingChannels.addAll(sub.channels);
          }

          if (remainingChannels.isNotEmpty) {
            await Future.delayed(Duration.zero, () => _createSocket());
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