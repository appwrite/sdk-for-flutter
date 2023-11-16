import 'realtime.dart';
import 'realtime_subscription.dart';

abstract class RealtimeBase implements Realtime {
  @override
  Future<RealtimeSubscription> subscribe(List<String> channels);
}
