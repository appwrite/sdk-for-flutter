import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// A message the native Android plugin delivers for a hosted subscription.
class NativePushMessage {
  final String id;
  final String topic;
  final Uint8List payload;
  final int qos;

  /// Passed to [PushNative.ack] once the callback has run; the broker's PUBACK waits for it.
  final String ackToken;

  NativePushMessage(this.id, this.topic, this.payload, this.qos, this.ackToken);
}

/// The SDK's native Android plugin (see android/), which hosts background delivery on the same
/// core as the Appwrite Android SDK: saved subscriptions, scheduled wake-ups after
/// the app is killed, reboot resume, notifications and foreground mode.
class PushNative {
  static const String _methodChannel = 'appwrite.push';
  static const String _eventChannel = 'appwrite.push/events';
  static final PushNative _plugin = PushNative._(
    const MethodChannel(_methodChannel),
    const EventChannel(_eventChannel),
  );

  final MethodChannel _methods;
  final EventChannel _events;
  Stream<Map<Object?, Object?>>? _stream;

  PushNative._(this._methods, this._events);

  /// The plugin's channels on [messenger] instead of the engine's, for tests that stand in for
  /// the plugin.
  @visibleForTesting
  PushNative.forMessenger(BinaryMessenger messenger)
    : _methods = MethodChannel(
        _methodChannel,
        const StandardMethodCodec(),
        messenger,
      ),
      _events = EventChannel(
        _eventChannel,
        const StandardMethodCodec(),
        messenger,
      );

  /// Used instead of the plugin by [Push] instances created while it is set, in tests.
  @visibleForTesting
  static PushNative? debugInstance;

  /// The plugin on Android, else null.
  static PushNative? get instance =>
      debugInstance ?? (Platform.isAndroid ? _plugin : null);

  /// Host [subscriptionsJson] on the background connection described by [configJson]. Completes
  /// once the connection is up and every filter is subscribed, or throws why not.
  Future<void> host(String configJson, String subscriptionsJson) =>
      _methods.invokeMethod<void>('host', {
        'config': configJson,
        'subscriptions': subscriptionsJson,
      });

  /// Ask for the notification permission background messages are posted with (Android 13+),
  /// without waiting for the answer. False when no Activity was attached to ask from.
  Future<bool> requestNotificationPermission() async =>
      await _methods.invokeMethod<bool>('requestNotificationPermission') ??
      false;

  /// Acknowledge a message once its callback has run.
  Future<void> ack(String token) =>
      _methods.invokeMethod<void>('ack', {'token': token});

  /// Stop hosting the live subscriptions, keeping the ones saved by an earlier run.
  Future<void> release() => _methods.invokeMethod<void>('release');

  /// Stop background delivery and forget every saved subscription.
  Future<void> stop() => _methods.invokeMethod<void>('stop');

  /// Run background delivery in a foreground service; saved across restarts.
  Future<void> setForeground(bool enabled) =>
      _methods.invokeMethod<void>('setForeground', {'enabled': enabled});

  /// Whether an earlier run saved background subscriptions that are still delivered.
  Future<bool> hasSaved() async =>
      await _methods.invokeMethod<bool>('hasSaved') ?? false;

  /// Resume saved background delivery now instead of at the next scheduled run, with the
  /// credential set on the client (null when none is): a rotated session of the same user
  /// replaces the saved one, and another user drops the saved subscriptions.
  Future<void> resume(String? authMethod, String? credential) =>
      _methods.invokeMethod<void>('resume', {
        'authMethod': authMethod,
        'credential': credential,
      });

  /// What background delivery can rely on, as JSON.
  Future<String?> backgroundStatus() =>
      _methods.invokeMethod<String>('backgroundStatus');

  /// Open the system screen that allows exact alarms; false when there is nothing to ask.
  Future<bool> requestExactAlarms() async =>
      await _methods.invokeMethod<bool>('requestExactAlarms') ?? false;

  /// Ask to exempt the app from battery optimisation; false when there is nothing to ask.
  Future<bool> requestIgnoreBatteryOptimizations() async =>
      await _methods.invokeMethod<bool>('requestIgnoreBatteryOptimizations') ??
      false;

  /// Record whether onError is registered; returns a refusal kept while it was not, once.
  Future<String?> setErrorCallback(bool registered) => _methods
      .invokeMethod<String>('setErrorCallback', {'registered': registered});

  /// The default client id for a credential, so a foreground connection shares its session.
  Future<String> defaultClientId(String authMethod, String credential) async =>
      await _methods.invokeMethod<String>('defaultClientId', {
        'authMethod': authMethod,
        'credential': credential,
      }) ??
      '';

  /// Listen to the plugin's messages and errors.
  StreamSubscription<Map<Object?, Object?>> listen({
    required void Function(NativePushMessage message) onMessage,
    required void Function(String message) onError,
  }) {
    final stream =
        _stream ??=
            _events
                .receiveBroadcastStream()
                .map((event) => event as Map<Object?, Object?>)
                .asBroadcastStream();
    return stream.listen((event) {
      if (event['type'] == 'message') {
        onMessage(
          NativePushMessage(
            event['id'] as String,
            event['topic'] as String,
            event['payload'] as Uint8List,
            event['qos'] as int,
            event['ackToken'] as String,
          ),
        );
      } else if (event['type'] == 'error') {
        onError(event['message'] as String? ?? 'Background push failed');
      }
    });
  }
}
