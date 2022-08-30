import 'realtime_message.dart';

class RealtimeSubscription {
  final Stream<RealtimeMessage> stream;
  final Future<void> Function() close;

  RealtimeSubscription({required this.stream, required this.close});
}
