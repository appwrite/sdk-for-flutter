import 'realtime_subscription.dart';
import 'realtime.dart';

abstract class RealtimeBase implements Realtime {
  @override
  RealtimeSubscription subscribe(
    List<Object> channels, {
    List<String> queries = const [],
  }); // Object can be String or Channel<T>
}
