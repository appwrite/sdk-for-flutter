import 'realtime_stub.dart'
    if (dart.library.js_interop) 'realtime_browser.dart'
    if (dart.library.io) 'realtime_io.dart';
import 'realtime_subscription.dart';
import 'service.dart';
import 'client.dart';

/// Realtime allows you to listen to any events on the server-side in realtime using the subscribe method.
abstract class Realtime extends Service {
  /// Initializes a [Realtime] service
  factory Realtime(ClientAuth client) => createRealtime(client);

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
  /// You can also use Channel builders:
  /// ```dart
  /// final subscription = realtime.subscribe([
  ///   Channel.database('db').collection('col').document('doc').create(),
  ///   Channel.bucket('bucket').file('file').update(),
  ///   'account.*'
  /// ]);
  /// ```
  RealtimeSubscription subscribe(
    List<Object> channels, {
    List<String> queries = const [],
  }); // Object can be String or Channel<T>

  /// Close the WebSocket connection and drop all active subscriptions client-side.
  /// Use this instead of calling [RealtimeSubscription.unsubscribe] on every
  /// subscription when you want to tear everything down.
  Future<void> disconnect();

  /// Create or upsert a presence entry for the current authenticated user
  /// over the existing realtime connection.
  ///
  /// Requires an authenticated user and an open WebSocket connection
  /// (subscribe to a channel first if you don't have one yet).
  ///
  /// Fire-and-forget: returns void and does not await the server response.
  /// Mirrors the `subscribe()` shape — call without `await`. Throws synchronously
  /// if there is no open WebSocket connection.
  ///
  /// ```dart
  /// realtime.subscribe(['account']);
  /// await Future.delayed(Duration(seconds: 1)); // let the WS open
  /// realtime.upsertPresence(
  ///   status: 'online',
  ///   presenceId: 'p-1',
  ///   metadata: {'device': 'web'},
  /// );
  /// ```
  void upsertPresence({
    required String status,
    required String presenceId,
    List<String>? permissions,
    Map<String, dynamic>? metadata,
  });

  /// The [close code](https://datatracker.ietf.org/doc/html/rfc6455#section-7.1.5) set when the WebSocket connection is closed.
  ///
  /// Before the connection has been closed, this will be `null`.
  int? get closeCode => null;
}
