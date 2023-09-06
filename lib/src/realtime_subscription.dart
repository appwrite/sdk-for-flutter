import 'realtime_message.dart';

/// Realtime Subscription
class RealtimeSubscription {
  /// Stream of [RealtimeMessage]s
  final Stream<RealtimeMessage> stream;

  /// List of channels
  List<String> channels;

  /// Closes the subscription
  final Future<void> Function() close;

  /// Initializes a [RealtimeSubscription]
  RealtimeSubscription({required this.stream, required this.close, required this.channels});
}
