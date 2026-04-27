import 'dart:async';

import 'realtime_message.dart';

/// Realtime Subscription
class RealtimeSubscription {
  /// Stream of [RealtimeMessage]s
  final Stream<RealtimeMessage> stream;

  final StreamController<RealtimeMessage> controller;

  /// List of channels
  List<String> channels;

  /// List of query strings
  List<String> queries;

  /// Removes this subscription only. The WebSocket stays open so other subscriptions
  /// keep receiving events — call `Realtime.disconnect()` to tear the connection down.
  final Future<void> Function() unsubscribe;

  /// Replace the channels and/or queries on this subscription without recreating it.
  final Future<void> Function({List<Object>? channels, List<String>? queries})
      update;

  /// Alias of [unsubscribe] that also closes the socket when this was the last active
  /// subscription. Prefer [unsubscribe] plus [Realtime.disconnect] for explicit control.
  final Future<void> Function() close;

  /// Initializes a [RealtimeSubscription]
  RealtimeSubscription({
    required this.close,
    required this.unsubscribe,
    required this.update,
    required this.channels,
    required this.queries,
    required this.controller,
  }) : stream = controller.stream;
}
