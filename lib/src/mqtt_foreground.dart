import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' show DartPluginRegistrant;

import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

import 'client.dart';
import 'exception.dart';
import 'mqtt.dart';
import 'mqtt_notification.dart';

/// Android/iOS background delivery for the native (dart:io) push service.
///
/// Flutter cannot keep the app's own isolate running once the app is closed, so a
/// subscription with `background: true` runs the push connection inside a background isolate
/// held alive by an Android foreground service ([FlutterBackgroundService]). That isolate
/// owns the single MQTT connection, posts a local notification per message
/// ([FlutterLocalNotificationsPlugin]) for the filters that opted into background, and
/// forwards every message back to the app (when it is alive) over a service event so in-app
/// callbacks still fire — mirroring the Android/React Native SDKs' foreground mode.
///
/// Config is handed to the isolate through a small JSON file in the app documents
/// directory (the isolate does not share the app's memory), and the running isolate is kept
/// in sync via service events. The config file (which holds the credential) is deleted when
/// background delivery stops.

const String _channelId = 'appwrite-push';
const String _channelName = 'Notifications';
const String _messageEvent = 'appwrite.push.message';
const String _topicsEvent = 'appwrite.push.topics';
const String _stopEvent = 'appwrite.push.stop';
const String _errorEvent = 'appwrite.push.error';

// How long to wait before retrying a background subscription that failed (SUBACK/connect),
// so delivery converges instead of silently missing messages.
const Duration _retryDelay = Duration(seconds: 2);

/// The service event the app listens on to forward background messages to callbacks.
String get pushForegroundMessageEvent => _messageEvent;

// Notification taps in the app isolate (iOS): each notification the background isolate posts
// carries its message's topic and payload, read back when it is tapped.
final FlutterLocalNotificationsPlugin _appNotifications =
    FlutterLocalNotificationsPlugin();
final StreamController<PushNotificationOpened> _localTaps =
    StreamController<PushNotificationOpened>.broadcast();
Future<void>? _localTapsReady;
bool _launchTapReported = false;

PushNotificationOpened? _openedFrom(String? payload) {
  try {
    final tap = jsonDecode(payload ?? '') as Map<String, dynamic>;
    return PushNotificationOpened.fromPayload(
      tap['topic'] as String,
      tap['payload'] as String,
    );
  } catch (_) {
    return null;
  }
}

Future<void> _ensureLocalTaps() =>
    _localTapsReady ??= _appNotifications
        .initialize(
          const InitializationSettings(iOS: DarwinInitializationSettings()),
          onDidReceiveNotificationResponse: (response) {
            final opened = _openedFrom(response.payload);
            if (opened != null) {
              _localTaps.add(opened);
            }
          },
        )
        .then((_) {});

/// iOS: the tap on a background notification that launched the app, once, or null.
Future<PushNotificationOpened?> localNotificationLaunch() async {
  if (!Platform.isIOS || _launchTapReported) {
    return null;
  }
  _launchTapReported = true;
  await _ensureLocalTaps();
  final details = await _appNotifications.getNotificationAppLaunchDetails();
  return details?.didNotificationLaunchApp == true
      ? _openedFrom(details!.notificationResponse?.payload)
      : null;
}

/// iOS: call [callback] for each tap on a background notification. Returns a function that
/// stops listening.
void Function() listenLocalNotificationTaps(
  void Function(PushNotificationOpened opened) callback,
) {
  if (!Platform.isIOS) {
    return () {};
  }
  unawaited(_ensureLocalTaps());
  final subscription = _localTaps.stream.listen(callback);
  return () => unawaited(subscription.cancel());
}

/// The service event the isolate relays its errors on, so the app's onError sees them.
String get pushForegroundErrorEvent => _errorEvent;

// Relay an isolate error to the app (if alive) as its message.
void _relayError(ServiceInstance service, Object error) {
  service.invoke(_errorEvent, {
    'message':
        error is AppwriteException
            ? (error.message ?? error.toString())
            : error.toString(),
  });
}

Future<File> _configFile() async {
  final dir = await getApplicationDocumentsDirectory();
  return File('${dir.path}/appwrite_push_foreground.json');
}

Future<void> _writeConfig(
  Client client, {
  required String serviceTitle,
  required List<String> topics,
  required Map<String, String> notify,
  required Map<String, int> qos,
}) async {
  final config = <String, dynamic>{
    'endpoint': client.endPoint,
    'endpointPush': client.config['endpointPush'],
    'project': client.config['project'] ?? '',
    'jwt': client.config['jwt'] ?? client.config['jWT'],
    'session': client.config['session'],
    'pushClientId': client.config['pushClientId'],
    'title': serviceTitle,
    'topics': topics,
    'notify': notify,
    'qos': qos,
  };
  (await _configFile()).writeAsStringSync(jsonEncode(config));
}

// Delete the config file (which holds the credential) so it does not linger on disk after
// background delivery ends.
Future<void> _deleteConfig() async {
  try {
    final file = await _configFile();
    if (file.existsSync()) {
      file.deleteSync();
    }
  } catch (_) {}
}

/// Start the background service (or, if already running, update its topics/notify config
/// live). Called on the app isolate whenever the set of background subscriptions changes.
/// [topics] is the full union the single connection subscribes to; [notify] maps the filters
/// that opted into background to their notification titles.
Future<void> syncPushForeground(
  Client client, {
  required String serviceTitle,
  required List<String> topics,
  required Map<String, String> notify,
  required Map<String, int> qos,
}) async {
  await _writeConfig(
    client,
    serviceTitle: serviceTitle,
    topics: topics,
    notify: notify,
    qos: qos,
  );

  final service = FlutterBackgroundService();
  if (await service.isRunning()) {
    // The isolate is already up: hand it the new topic/notify/qos set so a later
    // subscribe/unsubscribe/update takes effect without a restart.
    service.invoke(_topicsEvent, {
      'topics': topics,
      'notify': notify,
      'qos': qos,
    });
    return;
  }

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: pushForegroundEntry,
      isForegroundMode: true,
      autoStart: false,
      notificationChannelId: _channelId,
      initialNotificationTitle: serviceTitle,
      initialNotificationContent: 'Listening for messages',
    ),
    iosConfiguration: IosConfiguration(
      onForeground: pushForegroundEntry,
      autoStart: false,
    ),
  );
  await service.startService();
}

/// Ask the background service to disconnect and stop, and delete the config file.
Future<void> stopPushForeground() async {
  FlutterBackgroundService().invoke(_stopEvent);
  await _deleteConfig();
}

Map<String, String> _notifyOf(dynamic raw) {
  if (raw is Map) {
    return raw.map((key, value) => MapEntry('$key', '$value'));
  }
  return <String, String>{};
}

Map<String, int> _qosOf(dynamic raw) {
  if (raw is Map) {
    return raw.map((key, value) => MapEntry('$key', (value as num).toInt()));
  }
  return <String, int>{};
}

/// Background isolate entry point: opens the connection, subscribes to the persisted
/// topics (kept in sync via [_topicsEvent]), posts a notification per message for the
/// filters that opted into background and forwards every message to the app.
@pragma('vm:entry-point')
Future<void> pushForegroundEntry(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  final notifications = FlutterLocalNotificationsPlugin();
  final Map<String, dynamic> config;
  try {
    await notifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
    config =
        jsonDecode((await _configFile()).readAsStringSync())
            as Map<String, dynamic>;
  } catch (e) {
    _relayError(
      service,
      AppwriteException('Background push failed to start: $e'),
    );
    await _deleteConfig();
    service.stopSelf();
    return;
  }

  final client = Client()
      .setEndpoint(config['endpoint'] as String)
      .setProject(config['project'] as String);
  final jwt = config['jwt'] as String?;
  final session = config['session'] as String?;
  if (jwt != null && jwt.isNotEmpty) {
    client.setJWT(jwt);
  } else if (session != null && session.isNotEmpty) {
    client.setSession(session);
  }
  final endpointPush = config['endpointPush'] as String?;
  if (endpointPush != null && endpointPush.isNotEmpty) {
    client.setPushEndpoint(endpointPush);
  }
  final pushClientId = config['pushClientId'] as String?;
  if (pushClientId != null && pushClientId.isNotEmpty) {
    client.setPushClientId(pushClientId);
  }

  // Connection, subscribe and broker errors go to the app's onError. A failed subscribe
  // reaches it through here and is then retried below.
  final push = Push(client).onError((error) => _relayError(service, error));

  // filter -> notification title, for the filters that opted into background. Reassigned on
  // each [_topicsEvent]; the subscribe closures read the current map, so title/opt-in changes
  // take effect without resubscribing.
  var notify = _notifyOf(config['notify']);
  // filter -> QoS (1 reliable / 0 not) requested by the app for each topic.
  var qos = _qosOf(config['qos']);

  // One broker subscription per topic so topics can be added/removed independently as the
  // app's subscriptions change, plus the QoS each is currently subscribed at (so a QoS
  // change resubscribes rather than being skipped as "already subscribed").
  final subscriptions = <String, PushSubscription>{};
  final subscribedQos = <String, int>{};

  Future<void> applyTopics(List<String> topics) async {
    final wanted = topics.toSet();
    for (final topic in subscriptions.keys.toList()) {
      if (!wanted.contains(topic)) {
        subscriptions.remove(topic)?.unsubscribe();
        subscribedQos.remove(topic);
      }
    }
    for (final topic in wanted) {
      final desiredQos = qos[topic] ?? 1;
      if (subscriptions.containsKey(topic)) {
        if (subscribedQos[topic] == desiredQos) {
          continue;
        }
        // QoS changed for this topic: drop and resubscribe at the new level.
        subscriptions.remove(topic)?.unsubscribe();
      }
      final filter = topic;
      subscribedQos[topic] = desiredQos;
      subscriptions[topic] = await push.subscribe(topic, (message) {
        // Notify only for filters that opted into background, each with its own title.
        final title = notify[filter];
        if (title != null) {
          final content = PushNotificationContent.of(message);
          notifications.show(
            message.topic.hashCode,
            content.titleOr(title),
            content.bodyFor(message),
            const NotificationDetails(
              android: AndroidNotificationDetails(
                _channelId,
                _channelName,
                importance: Importance.high,
              ),
              iOS: DarwinNotificationDetails(),
            ),
            payload: jsonEncode({
              'topic': message.topic,
              'payload': message.data,
            }),
          );
        }
        // Forward to the app isolate (if alive) so in-app callbacks still fire.
        service.invoke(_messageEvent, {
          'topic': message.topic,
          'payload': message.data,
          'qos': message.qos,
        });
      }, retry: desiredQos == 1);
    }
  }

  // Serialize topic updates: applyTopics awaits push.subscribe, so overlapping runs could
  // otherwise subscribe a topic twice (losing an unsubscribe handle) or apply out of order.
  // Chaining runs them one at a time, in arrival order.
  var topicQueue = Future<void>.value();
  // The last requested topic set, so a failed subscribe can be retried against what is
  // currently wanted (topics may have changed again by the time the retry fires).
  var wantedTopics = <String>[];
  var retryScheduled = false;

  void queueTopics(List<String> topics) {
    wantedTopics = topics;
    // A subscribe can fail (SUBACK refused, connection dropped mid-CONNECT); applyTopics
    // skips already-subscribed topics, so retrying the current wanted set converges on the
    // missing ones instead of silently dropping them.
    topicQueue = topicQueue.then((_) => applyTopics(topics)).catchError((
      Object _,
    ) {
      if (retryScheduled) {
        return;
      }
      retryScheduled = true;
      Timer(_retryDelay, () {
        retryScheduled = false;
        queueTopics(wantedTopics);
      });
    });
  }

  service.on(_topicsEvent).listen((data) {
    notify = _notifyOf(data?['notify']);
    qos = _qosOf(data?['qos']);
    final topics =
        ((data?['topics'] as List?) ?? const <dynamic>[]).cast<String>();
    queueTopics(topics);
  });

  service.on(_stopEvent).listen((_) async {
    for (final subscription in subscriptions.values) {
      subscription.unsubscribe();
    }
    push.close();
    await _deleteConfig();
    service.stopSelf();
  });

  queueTopics((config['topics'] as List).cast<String>());
}
