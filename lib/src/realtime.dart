import 'realtime_stub.dart'
    if (dart.library.html) 'realtime_browser.dart'
    if (dart.library.io) 'realtime_io.dart';
import 'realtime_subscription.dart';
import 'service.dart';
import 'client.dart';

/// Realtime allows you to listen to any events on the server-side in realtime using the subscribe method.
abstract class Realtime extends Service {
  /// Initializes a [Realtime] service
  factory Realtime(Client client) => createRealtime(client);

  /// Subscribes to Appwrite events and returns a `RealtimeSubscription` object, which can be used
  /// to listen to events on the channels in realtime and to close the subscription to stop listening.
  ///
  /// Possible channels are:
  /// - account
  /// - collections
  /// - collections.[ID]
  /// - collections.[ID].documents
  /// - documents
  /// - documents.[ID]
  /// - files
  /// - files.[ID]
  /// - executions
  /// - executions.[ID]
  /// - functions.[ID]
  /// - teams
  /// - teams.[ID]
  /// - memberships
  /// - memberships.[ID]
  ///
  /// The sample shows how you could use realtime to listen to changes in a collections.
  ///
  /// ```dart
  /// final realtime = Realtime(client);
  /// final subscription = realtime.subscribe(['collections']);
  /// subscription.stream.listen((event) {
  ///   print(event);
  /// });
  ///
  /// subscription.close();
  /// ```
  ///
  RealtimeSubscription subscribe(List<String> channels);

  /// The [close code](https://datatracker.ietf.org/doc/html/rfc6455#section-7.1.5) set when the WebSocket connection is closed.
  ///
  /// Before the connection has been closed, this will be `null`.
  int? get closeCode => null;
}
