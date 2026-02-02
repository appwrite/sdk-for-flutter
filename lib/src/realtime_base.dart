import 'realtime_subscription.dart';
import 'realtime.dart';

abstract class RealtimeBase implements Realtime {
  @override
  RealtimeSubscription subscribe(
      List<Object> channels); // Object can be String or Channel<T>
}
