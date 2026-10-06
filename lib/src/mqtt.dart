import 'mqtt_browser.dart' if (dart.library.io) 'mqtt_io.dart';
import 'service.dart';
import 'client.dart';
import 'mqtt_message.dart';

/// A callback invoked for every message delivered on a subscribed topic.
typedef PushCallback = void Function(PushMessage message);

/// Handle for a live subscription created with [Push.subscribe].
///
/// Unlike the realtime service's bare unsubscribe callable, a push subscription carries
/// per-subscription state (background delivery, notification title), so [subscribe]
/// returns this handle instead: [unsubscribe] drops it (and closes the connection once
/// the last one is gone) and [update] toggles its options live without resubscribing.
abstract class PushSubscription {
  /// Drop this subscription. Closes the connection once the last one is gone.
  void unsubscribe();

  /// Live-update this subscription's [background] delivery, notification [title] and/or
  /// [retry] (QoS). Only the arguments you pass change; the rest stay as they
  /// were. Changing [retry] re-subscribes this subscription's topics at the
  /// new QoS.
  void update({bool? background, String? title, bool? retry});
}

/// Appwrite native push service — the realtime analog delivered over an MQTT
/// broker, without FCM or APNS. While the app is alive the connection stays open and each
/// message is handed to your callback; a subscription can also opt into background
/// delivery (a notification per message, and on mobile continued delivery while the app is
/// backgrounded or closed).
///
/// The connection has no tunables — it always keeps its session (clean start off) so the
/// broker can redeliver missed messages, and reliability is chosen per subscription via
/// [subscribe]'s `retry`. TLS (and skipping cert verification via a
/// `?tlsInsecure=true` query flag) is derived from the endpoint, so the whole connection
/// is described in one place. `subscribe` opens the connection lazily and returns a
/// [PushSubscription] handle. The credential is read off the client — set a JWT or session
/// on it (`Client.setJWT` / `Client.setSession`), the same way every other service reads
/// auth. The broker location comes from `Client.setPushEndpoint()` (or the client
/// endpoint) and a stable id from `Client.setPushClientId()`.
///
/// ```dart
/// final client = Client().setEndpoint('...').setProject('...').setJWT(jwt);
/// final push = Push(client);
/// final sub = await push.subscribe('user/123/#', (message) {
///   print('${message.topic}: ${message.data}');
/// });
///
/// // sub.update(background: true, title: 'Messages');
/// sub.unsubscribe();
/// ```
abstract class Push extends Service {
  /// Initializes a [Push] service.
  factory Push(Client client) => createPush(client);

  /// Register a callback invoked when the connection opens (CONNACK success).
  Push onOpen(void Function() callback);

  /// Register a callback invoked when the connection closes.
  Push onClose(void Function() callback);

  /// Register a callback invoked with every error the service hits: a failed or refused
  /// connect or reconnect (carrying the broker's reason string when it sent one), a
  /// DISCONNECT from the broker, a rejected SUBSCRIBE and background delivery failures.
  /// Errors a call also throws (such as [subscribe]'s) are reported here as well. Errors that
  /// no call throws are never thrown, so they cannot crash the app: with no callback
  /// registered they are logged.
  Push onError(void Function(Object error) callback);

  /// Subscribe to one or more topics, resolving to a [PushSubscription] handle.
  ///
  /// [topics] is a single topic or a list of them, each a string or a `Topic` builder
  /// (e.g. `Topic.path(['user', userId]).all()`). Pass `null` to subscribe to the
  /// signed-in user's own `users/<userId>` topic ("messages for me") without knowing any
  /// topic: the user id is read off the client's JWT (or, without one, its session) with
  /// no network call, and `AppwriteException` is thrown when neither is set.
  /// Like FCM/APNs delivery, the `null` form defaults to [background] `true` (topics default to
  /// `false`) and, as always, [retry] `true` (QoS 1); pass either to override.
  ///
  /// ```dart
  /// final sub = await push.subscribe(null, (message) {
  ///   print(message.data);
  /// });
  /// ```
  ///
  /// The future resolves only once every subscription has been acknowledged (SUBACK), so a
  /// subscribe-then-publish is reliable, and [onOpen]/[onClose]/[onError] observe the
  /// in-process connection. On Android a [background] subscription moves the connection to the
  /// SDK's native plugin, which also resolves after SUBACK and forwards messages and errors (to
  /// [onError]) but not its connection lifecycle, so [onOpen]/[onClose] do not fire for it. On
  /// iOS it hands the connection to a background isolate, which subscribes asynchronously and
  /// retries failures internally, so it resolves once the isolate has the subscription.
  ///
  /// [retry] chooses this subscription's delivery guarantee: `true` (the
  /// default) subscribes at QoS 1 so the broker holds this topic's messages and redelivers
  /// them on reconnect; `false` uses QoS 0 (at-most-once, may be lost). The connection
  /// always keeps its session, so replay is a purely per-subscription choice.
  ///
  /// Set [background] to also keep receiving while the app is backgrounded or closed and post a
  /// notification per message with [title] (defaulting to the message topic). Toggle these
  /// later with [PushSubscription.update].
  ///
  /// On Android the SDK's native plugin saves the subscription and keeps delivering after the
  /// app is killed, the device restarts or the app updates, until it is unsubscribed or [close]
  /// is called: a scheduled job and alarm wake the app every 15 to 60 seconds to reconnect, and
  /// the broker replays what was sent in between ([retry]). [setForeground] adds a foreground
  /// service for immediate delivery. It reconnects with the credential saved at subscribe time,
  /// so use a session rather than a short-lived JWT. On iOS it runs the connection in a
  /// background isolate via `flutter_background_service`; on the web it posts a browser
  /// notification while the tab is open.
  Future<PushSubscription> subscribe(
    Object? topics, // String, Topic, ResolvedTopic, a List, or null (own user)
    PushCallback callback, {
    bool? background,
    String? title,
    bool retry,
  });

  /// Android: run background delivery in a foreground service (with a quiet ongoing
  /// notification), for immediate delivery even after the app is killed and during Doze,
  /// instead of only the scheduled wake-ups. Saved, so it applies after restarts too. Call it
  /// while the app is in the foreground: Android 12+ refuses to start the service from the
  /// background. It only affects [background] subscriptions. A no-op elsewhere.
  Future<void> setForeground(bool enabled);

  /// Tear down the connection and drop all subscriptions. On Android this also stops
  /// background delivery, including subscriptions saved by an earlier run: call it on sign-out.
  void close();
}
