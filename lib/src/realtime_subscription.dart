import 'realtime_message.dart';

/// Realtime Subscription
class RealtimeSubscription {
  /// Stream of [RealtimeMessage]s
  final Stream<RealtimeMessage> stream;

  /// Closes the subscription
  final Future<void> Function() close;

  /// Initializes a [RealtimeSubscription]
  RealtimeSubscription({required this.stream, required this.close});
}
