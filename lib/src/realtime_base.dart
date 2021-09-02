import 'realtime_subscription.dart';
import 'realtime.dart';

abstract class RealtimeBase implements Realtime {
  RealtimeSubscription subscribe(List<String> channels);
}
