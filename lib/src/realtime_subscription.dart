import 'realtime_message.dart';

class RealtimeSubscription {
  final Stream<RealtimeMessage> stream;
  final Function() close;

  RealtimeSubscription({required this.stream, required this.close});
}
