import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'dart:math';
import 'dart:typed_data';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_browser_client.dart';
import 'package:typed_data/typed_data.dart' as typed;
import 'client.dart';
import 'exception.dart';
import 'mqtt.dart';
import 'mqtt_message.dart';
import 'mqtt_notification.dart';

Push createPush(Client client) => PushWeb(client);

class _Subscription {
  final String filter;
  final PushCallback callback;
  bool background;
  String? title;
  bool retry;
  bool notifyInForeground;

  _Subscription(
    this.filter,
    this.callback, {
    this.background = false,
    this.title,
    this.retry = true,
    this.notifyInForeground = false,
  });
}

class _SubscriptionHandle implements PushSubscription {
  final void Function() _unsubscribe;
  final void Function({
    bool? background,
    String? title,
    bool? retry,
    bool? notifyInForeground,
  })
  _update;

  _SubscriptionHandle(this._unsubscribe, this._update);

  @override
  void unsubscribe() => _unsubscribe();

  @override
  void update({
    bool? background,
    String? title,
    bool? retry,
    bool? notifyInForeground,
  }) => _update(
    background: background,
    title: title,
    retry: retry,
    notifyInForeground: notifyInForeground,
  );
}

// Fixed connection tuning — not exposed as an option.
const int _keepAliveSeconds = 60;

/// Web push transport. A browser cannot open a raw TCP socket, so the connection is
/// MQTT over WebSocket (`ws://` / `wss://`) via [MqttBrowserClient]; the native
/// (`dart:io`) build in `mqtt_io.dart` uses a TCP socket instead. The API is identical.
class PushWeb implements Push {
  @override
  final Client client;

  final String _host;
  final int _port;
  final bool _tls;
  final String _path;

  MqttBrowserClient? _mqtt;
  Future<void>? _connecting;
  int _connectionEpoch = 0;
  Completer<void>? _openCancel;
  String _connectedKey = '';
  bool _resubscribeOnConnect = false;

  void Function()? _onOpen;
  void Function()? _onClose;
  void Function(Object error)? _onError;

  // Resolved once per instance: a reconnect rebuilds the client, and if each rebuild drew a
  // new random id the broker would treat it as a new session and drop this client's replay
  // cursor. A stable id from Client.setPushClientId() resumes replay across reloads;
  // otherwise a per-instance id is generated. Reusing one id keeps the session stable.
  late final String _resolvedClientId = _pushClientId();

  // Local id -> subscription (filter + callback + per-sub options). The id is never sent to
  // the broker; it only lets the same topic carry more than one callback.
  final Map<String, _Subscription> _subscriptions = {};
  // topic filter -> FIFO queue of completers resolved on each SUBACK. A queue (not a
  // single completer) so two concurrent subscribes to the same topic both resolve.
  final Map<String, List<Completer<void>>> _subAcks = {};

  factory PushWeb(Client client) {
    // The broker location comes from Client.setPushEndpoint() when set (e.g.
    // "wss://host"), otherwise from the regular endpoint.
    final pushEndpoint = client.config['endpointPush'] ?? client.endPoint;
    // Secure by default: WSS on when the endpoint scheme is secure, so the credential in the
    // CONNECT packet is not sent over a plaintext socket.
    final resolvedTls = _secureScheme(pushEndpoint);
    final resolvedPort = _pushEndpointPort(client) ?? (resolvedTls ? 443 : 80);
    // When no explicit push endpoint is set, default to a `push.` host on the regular
    // endpoint (mirroring how realtime derives from the endpoint, on the push subdomain).
    final resolvedHost =
        client.config['endpointPush'] != null
            ? _hostOf(pushEndpoint)
            : 'push.${_hostOf(pushEndpoint)}';
    return PushWeb._(
      client,
      host: resolvedHost,
      port: resolvedPort,
      tls: resolvedTls,
      path: _pushPath(client),
    );
  }

  PushWeb._(
    this.client, {
    required String host,
    required int port,
    required bool tls,
    required String path,
  }) : _host = host,
       _port = port,
       _tls = tls,
       _path = path;

  // Empty when the app did not set one: the broker derives a stable id server-side (keyed on
  // the credential/project) so the replay cursor resumes across reloads.
  // Client.setPushClientId(id) overrides it with an explicit id.
  String _pushClientId() => client.config['pushClientId'] ?? '';

  static bool _secureScheme(String endpoint) {
    try {
      final scheme = Uri.parse(endpoint).scheme;
      return scheme == 'https' ||
          scheme == 'wss' ||
          scheme == 'mqtts' ||
          scheme == 'ssl';
    } catch (_) {
      return false;
    }
  }

  static String _hostOf(String endpoint) {
    try {
      final host = Uri.parse(endpoint).host;
      return host.isEmpty ? 'localhost' : host;
    } catch (_) {
      return 'localhost';
    }
  }

  // Take the port from an explicitly-set push endpoint only (a regular http/https
  // endpoint's port is the API port, not the broker's).
  static int? _pushEndpointPort(Client client) {
    final endpoint = client.config['endpointPush'];
    if (endpoint == null) {
      return null;
    }
    try {
      final port = Uri.parse(endpoint).port;
      return port == 0 ? null : port;
    } catch (_) {
      return null;
    }
  }

  // The WebSocket path from an explicitly-set push endpoint, or the root path by
  // default (the broker serves MQTT-over-WebSocket at the root; no "/mqtt" is appended).
  static String _pushPath(Client client) {
    final endpoint = client.config['endpointPush'];
    if (endpoint != null) {
      try {
        final path = Uri.parse(endpoint).path;
        if (path.isNotEmpty && path != '/') {
          return path;
        }
      } catch (_) {}
    }
    return '';
  }

  // The broker subscription for a filter uses the highest QoS any subscription on it wants,
  // so a QoS-0 subscription never downgrades a QoS-1 one sharing the filter.
  MqttQos _effectiveQos(String filter) {
    final reliable = _subscriptions.values.any(
      (s) => s.filter == filter && s.retry,
    );
    return reliable ? MqttQos.atLeastOnce : MqttQos.atMostOnce;
  }

  @override
  Push onOpen(void Function() callback) {
    _onOpen = callback;
    return this;
  }

  @override
  Push onClose(void Function() callback) {
    _onClose = callback;
    return this;
  }

  @override
  Push onError(void Function(Object error) callback) {
    _onError = callback;
    return this;
  }

  // Errors already handed to onError, so one failure reaching it through two paths (a
  // refused CONNACK that also fails the subscribe waiting on it) is reported once.
  final Expando<bool> _reported = Expando<bool>();

  // Every error the service hits goes through here and reaches onError. It is never thrown
  // from here, so an error outside any call cannot crash the app.
  void _report(Object error) {
    try {
      if (_reported[error] == true) {
        return;
      }
      _reported[error] = true;
    } catch (_) {
      // Expando rejects strings/numbers; such an error is simply not de-duplicated.
    }
    final callback = _onError;
    if (callback == null) {
      // Never thrown (that would surface as an uncaught error from inside mqtt5_client):
      // with no onError registered it is logged, like Realtime does.
      developer.log('Push error', name: 'appwrite', error: error);
      return;
    }
    try {
      callback(error);
    } catch (callbackError, stackTrace) {
      developer.log(
        'Push onError threw',
        name: 'appwrite',
        error: callbackError,
        stackTrace: stackTrace,
      );
    }
  }

  // An error that is also thrown to the caller: onError sees it too, but with no onError
  // registered the caller's own throw is enough.
  void _notify(Object error) {
    if (_onError != null) {
      _report(error);
    }
  }

  @override
  Future<PushSubscription> subscribe(
    Object? topics,
    PushCallback callback, {
    bool? background,
    String? title,
    bool retry = true,
    bool notifyInForeground = false,
  }) async {
    final List<String> topicList;
    final MqttBrowserClient mqtt;
    try {
      topicList = _topicList(client, topics);
      mqtt = await _connect();
    } catch (e) {
      if (e is _Superseded) {
        return subscribe(
          topics,
          callback,
          background: background,
          title: title,
          retry: retry,
          notifyInForeground: notifyInForeground,
        );
      }
      _notify(e);
      rethrow;
    }
    final epoch = _connectionEpoch;
    // The own-user topic (topics == null) defaults to background delivery, like FCM/APNs.
    final wantsBackground = background ?? topics == null;

    if (wantsBackground) {
      _requestNotificationPermission();
    }

    final ids = <String>[];
    final acks = <Future<void>>[];

    void unsubscribe() {
      final maybeDowngrade = <String>{};
      for (final id in ids) {
        final entry = _subscriptions.remove(id);
        if (entry != null && entry.retry) {
          maybeDowngrade.add(entry.filter);
        }
        // Only unsubscribe the broker filter once its last local callback is gone.
        final stillUsed = _subscriptions.values.any(
          (s) => s.filter == entry?.filter,
        );
        if (entry != null && !stillUsed) {
          try {
            _mqtt?.unsubscribeStringTopic(entry.filter);
          } catch (e) {
            _report(e);
          }
        }
      }
      // A filter that lost its last QoS-1 sub but still has QoS-0 subs must be re-subscribed
      // lower, or the broker keeps replaying to at-most-once subs.
      for (final filter in maybeDowngrade) {
        final stillUsed = _subscriptions.values.any((s) => s.filter == filter);
        if (stillUsed && _effectiveQos(filter) == MqttQos.atMostOnce) {
          try {
            _mqtt?.subscribeWithSubscriptionList([
              MqttSubscription.withMaximumQos(
                MqttSubscriptionTopic(filter),
                MqttQos.atMostOnce,
              ),
            ]);
          } catch (e) {
            _report(e);
          }
        }
      }
      if (_subscriptions.isEmpty) {
        close();
      }
    }

    // The broker only starts routing a topic once its subscription is registered,
    // so publishing before the SUBACK races the message ahead of the subscription
    // and it is dropped (no retained replay on MQTT). Awaiting makes it reliable.
    // If any topic's SUBACK fails, roll this call's registrations back (and drop any
    // now-unused broker filter) so a failed subscribe leaks no callback, then rethrow.
    try {
      for (final topic in topicList) {
        final id = _randomId();
        ids.add(id);
        _subscriptions[id] = _Subscription(
          topic,
          callback,
          background: wantsBackground,
          title: title,
          retry: retry,
          notifyInForeground: notifyInForeground,
        );

        final completer = Completer<void>();
        (_subAcks[topic] ??= <Completer<void>>[]).add(completer);
        acks.add(completer.future);

        final subscription = MqttSubscription.withMaximumQos(
          MqttSubscriptionTopic(topic),
          _effectiveQos(topic),
        );
        mqtt.subscribeWithSubscriptionList([subscription]);
      }
      await Future.wait(acks);
    } catch (e) {
      if (epoch != _connectionEpoch) {
        for (final id in ids) {
          _subscriptions.remove(id);
        }
        return subscribe(
          topics,
          callback,
          background: background,
          title: title,
          retry: retry,
          notifyInForeground: notifyInForeground,
        );
      }
      unsubscribe();
      _notify(e);
      rethrow;
    }

    void update({
      bool? background,
      String? title,
      bool? retry,
      bool? notifyInForeground,
    }) {
      final changedFilters = <String>{};
      for (final id in ids) {
        final entry = _subscriptions[id];
        if (entry == null) {
          continue;
        }
        if (background != null) {
          entry.background = background;
        }
        if (title != null) {
          entry.title = title;
        }
        if (notifyInForeground != null) {
          entry.notifyInForeground = notifyInForeground;
        }
        if (retry != null && retry != entry.retry) {
          entry.retry = retry;
          changedFilters.add(entry.filter);
        }
      }
      if (background == true) {
        _requestNotificationPermission();
      }
      // Re-subscribe affected filters at their new effective QoS.
      // A rejected SUBACK reaches onError through [_onSubscribeFail].
      for (final filter in changedFilters) {
        try {
          _mqtt?.subscribeWithSubscriptionList([
            MqttSubscription.withMaximumQos(
              MqttSubscriptionTopic(filter),
              _effectiveQos(filter),
            ),
          ]);
        } catch (e) {
          _report(e);
        }
      }
    }

    return _SubscriptionHandle(unsubscribe, update);
  }

  void _requestNotificationPermission() {
    if (html.Notification.permission != 'granted') {
      unawaited(
        html.Notification.requestPermission().then<void>(
          (_) {},
          onError: _report,
        ),
      );
    }
  }

  // Background delivery on the web is a notification while the tab is open; there is no
  // foreground service.
  @override
  Future<void> setForeground(bool enabled) async {}

  @override
  Future<PushBackgroundStatus?> backgroundStatus() async => null;

  @override
  Future<bool> requestExactAlarms() async => false;

  @override
  Future<bool> requestIgnoreBatteryOptimizations() async => false;

  @override
  void close() {
    _mqtt?.disconnect();
    _mqtt = null;
    _connecting = null;
    _subscriptions.clear();
  }

  Future<MqttBrowserClient> _connect() {
    if ((_mqtt != null || _connecting != null) &&
        _connectedKey != _credentialKey) {
      _connectionEpoch++;
      _connecting = null;
      _openCancel?.complete();
      _openCancel = null;
      for (final waiting in _subAcks.values) {
        for (final completer in waiting) {
          if (!completer.isCompleted) {
            completer.completeError(const _Superseded());
          }
        }
      }
      _subAcks.clear();
      _mqtt?.disconnect();
      _mqtt = null;
      _resubscribeOnConnect = _subscriptions.isNotEmpty;
    }
    final mqtt = _mqtt;
    if (mqtt != null &&
        mqtt.connectionStatus?.state == MqttConnectionState.connected) {
      return Future.value(mqtt);
    }
    var connecting = _connecting;
    if (connecting == null) {
      connecting = _open();
      _connecting = connecting;
      // A failed open must not poison future attempts — clear the cached in-flight
      // future so a later subscribe/publish can retry.
      final pending = connecting;
      unawaited(
        pending.catchError((Object _) {
          if (identical(_connecting, pending)) {
            _connecting = null;
          }
        }),
      );
    }
    return connecting.then((_) => _mqtt!);
  }

  // The credential set on the client (via Client.setJWT / setSession), as (method, credential).
  (String, String) _credential() {
    final jwt = client.config['jwt'] ?? client.config['jWT'];
    final session = client.config['session'];
    if (jwt != null && jwt.isNotEmpty) {
      return ('appwrite-jwt', jwt);
    }
    if (session != null && session.isNotEmpty) {
      return ('appwrite-session', session);
    }
    throw AppwriteException(
      'No credential set on the client; call Client.setJWT() or Client.setSession() first.',
    );
  }

  String get _credentialKey {
    try {
      final (authMethod, credential) = _credential();
      return [
        _host,
        _port,
        _path,
        client.config['project'] ?? '',
        _resolvedClientId,
        authMethod,
        credential,
      ].join('|');
    } catch (_) {
      return '';
    }
  }

  Future<void> _open() async {
    final (authMethod, credential) = _credential();
    _connectedKey = _credentialKey;
    final epoch = _connectionEpoch;

    final project = client.config['project'] ?? '';
    // An empty client id makes the broker derive a stable id server-side (keyed on the
    // credential/project) and key its offline-replay cursor on it; Client.setPushClientId(id)
    // overrides with an explicit id. Resolved once per instance (see [_resolvedClientId]) so a
    // reconnect rebuild reuses the same id and resumes the same session.
    final clientId = _resolvedClientId;

    final scheme = _tls ? 'wss' : 'ws';
    final mqtt = MqttBrowserClient.withPort(
      '$scheme://$_host$_path',
      clientId,
      _port,
    );
    mqtt.keepAlivePeriod = _keepAliveSeconds;
    // The broker negotiates the "mqtt" WebSocket subprotocol; offer exactly that so the
    // handshake succeeds (a browser rejects the socket when the subprotocol is not echoed).
    mqtt.websocketProtocols = MqttConstants.protocolsSingleDefault;
    // Re-register every subscription automatically after a dropped connection.
    mqtt.autoReconnect = true;
    mqtt.resubscribeOnAutoReconnect = true;
    mqtt.onSubscribed = _onSubscribed;
    mqtt.onSubscribeFail = _onSubscribeFail;
    mqtt.onConnected = () => _onOpen?.call();
    final reconnects = _ReconnectWatch(mqtt, _report);
    mqtt.onAutoReconnect = reconnects.attemptStarted;
    mqtt.onAutoReconnected = reconnects.stop;
    mqtt.onDisconnected = () {
      reconnects.stop();
      // A DISCONNECT from the broker with an error reason code explains itself in its
      // MQTT 5 Reason String.
      final error = _brokerDisconnectError(mqtt);
      if (error != null) {
        _report(error);
      }
      _onClose?.call();
    };

    // Enhanced auth carried in the CONNECT properties, plus the project id as a
    // user property — exactly like the Python and React Native clients.
    final authData = typed.Uint8Buffer()..addAll(utf8.encode(credential));
    final connectMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .keepAliveFor(_keepAliveSeconds)
        .withAuthenticationMethod(authMethod)
        .withAuthenticationData(authData);
    // Clean start is always off (never call startClean), so the broker keeps this client's
    // session and can redeliver missed messages to QoS-1 subscriptions on reconnect. The
    // replay window itself is the broker's concern — we set no session expiry.
    connectMessage.addUserPropertyPair('projectId', project);
    mqtt.connectionMessage = connectMessage;

    _mqtt = mqtt;

    final cancel = Completer<void>();
    _openCancel = cancel;
    final failure = await _connectOrFail(mqtt, cancel.future, (error) {
      if (epoch != _connectionEpoch) {
        return;
      }
      // Let go of the client first: it is still being wound down, and a close() from
      // onError must not touch it.
      if (identical(_mqtt, mqtt)) {
        _mqtt = null;
      }
      _notify(error);
    });
    if (epoch != _connectionEpoch) {
      mqtt.disconnect();
      throw const _Superseded();
    }
    if (failure != null) {
      throw failure;
    }

    // Attach the delivery listener only after CONNACK — the `updates` stream is not
    // available until the connection is established.
    mqtt.updates.listen(_onData);

    if (_resubscribeOnConnect) {
      _resubscribeOnConnect = false;
      final filters = _subscriptions.values.map((s) => s.filter).toSet();
      for (final filter in filters) {
        mqtt.subscribeWithSubscriptionList([
          MqttSubscription.withMaximumQos(
            MqttSubscriptionTopic(filter),
            _effectiveQos(filter),
          ),
        ]);
      }
    }
  }

  void _onData(List<MqttReceivedMessage<MqttMessage>> events) {
    for (final received in events) {
      final publish = received.payload;
      if (publish is! MqttPublishMessage) {
        continue;
      }
      final topic = received.topic ?? '';
      final bytes = publish.payload.message;
      final payload =
          bytes == null ? Uint8List(0) : Uint8List.fromList(bytes.toList());
      final message = PushMessage(
        topic: topic,
        payload: payload,
        qos: publish.header?.qos.index ?? 0,
      );
      final content = PushNotificationContent.of(message);
      var shownServerTitle = false;
      for (final subscription in _subscriptions.values) {
        if (_matches(subscription.filter, topic)) {
          subscription.callback(message);
          // Notification is per-subscription: only subs that opted in show one, each with
          // its own title. A title the server sent replaces theirs, so it is shown once.
          if (subscription.background &&
              (html.document.visibilityState != 'visible' ||
                  subscription.notifyInForeground) &&
              !shownServerTitle &&
              html.Notification.supported &&
              html.Notification.permission == 'granted') {
            shownServerTitle = content.title != null;
            html.Notification(
              content.titleOr(subscription.title ?? topic),
              body: content.bodyFor(message),
            );
          }
        }
      }
    }
  }

  Completer<void>? _takeSubAck(String? topic) {
    final queue = _subAcks[topic];
    if (queue == null || queue.isEmpty) {
      return null;
    }
    final completer = queue.removeAt(0);
    if (queue.isEmpty) {
      _subAcks.remove(topic);
    }
    return completer;
  }

  void _onSubscribed(MqttSubscription subscription) {
    final completer = _takeSubAck(subscription.topic.rawTopic);
    if (completer != null && !completer.isCompleted) {
      completer.complete();
    }
  }

  void _onSubscribeFail(MqttSubscription subscription) {
    final topic = subscription.topic.rawTopic;
    final completer = _takeSubAck(topic);
    final error = AppwriteException('Failed to subscribe to $topic');
    if (completer != null && !completer.isCompleted) {
      // The subscribe waiting on this SUBACK throws it (and reports it to onError).
      completer.completeError(error);
    } else {
      // Nobody awaits this SUBSCRIBE (a resubscribe after reconnect or a QoS change), so
      // onError is the only place it can surface.
      _report(error);
    }
  }
}

/// Connect [mqtt]. Resolves to null once connected, or to the error the connect failed
/// with after handing it to [failed] and disconnecting [mqtt]: a refused CONNECT carries
/// the broker's MQTT 5 Reason String when it sent one.
///
/// mqtt5_client alone would not finish here: after a refused CONNECT that carries enhanced
/// auth, its connect() keeps waiting for a successful CONNACK. So the connection status is
/// watched for the refusal as well, and the pending connect() is then let go.
Future<Object?> _connectOrFail(
  MqttClient mqtt,
  Future<void> cancelled,
  void Function(Object error) failed,
) async {
  final connecting = mqtt.connect();
  final refused = Completer<void>();
  final watch = Timer.periodic(const Duration(milliseconds: 50), (_) {
    if (!refused.isCompleted && _refused(mqtt.connectionStatus)) {
      refused.complete();
    }
  });
  Object? failure;
  try {
    await Future.any([connecting, refused.future, cancelled]);
  } catch (e) {
    failure = e;
  } finally {
    watch.cancel();
  }
  final status = mqtt.connectionStatus;
  if (failure == null && status?.state == MqttConnectionState.connected) {
    return null;
  }
  final error = AppwriteException(
    status != null && _refused(status)
        ? _refusalMessage(status)
        : failure?.toString() ?? 'MQTT connection failed (${status?.state})',
  );
  failed(error);
  // Fail the caller now; winding down the library's pending connect() happens after.
  unawaited(_teardown(mqtt, connecting, refused.isCompleted ? status : null));
  return error;
}

/// Tear down a client whose connect failed. After a refusal [refusedStatus] is its status:
/// connect() only stops waiting once the status reads connected, so mark it so until
/// connect() returns, then disconnected again.
Future<void> _teardown(
  MqttClient mqtt,
  Future<Object?> connecting,
  MqttConnectionStatus? refusedStatus,
) async {
  if (refusedStatus != null) {
    refusedStatus.state = MqttConnectionState.connected;
    try {
      await connecting.timeout(const Duration(seconds: 10));
    } catch (_) {
      // The refusal is the error; how connect() ends no longer matters.
    }
    refusedStatus.state = MqttConnectionState.disconnected;
  }
  try {
    mqtt.disconnect();
  } catch (_) {
    // Already torn down; the connect failure is the error.
  }
}

/// Whether [status] holds a CONNACK the broker refused the connection with.
bool _refused(MqttConnectionStatus? status) {
  final code = status?.reasonCode;
  return status != null &&
      status.state != MqttConnectionState.connected &&
      code != null &&
      code != MqttConnectReasonCode.notSet &&
      code != MqttConnectReasonCode.success;
}

/// The broker's Reason String for a refused CONNECT, or a message naming the reason code.
String _refusalMessage(MqttConnectionStatus status) {
  final reason = status.reasonString;
  return reason != null && reason.isNotEmpty
      ? reason
      : 'MQTT authentication failed (CONNACK reason ${status.reasonCode})';
}

/// The error for a DISCONNECT the broker sent with an error reason code: its MQTT 5 Reason
/// String when present, else a message naming the reason code. Null for any other close.
AppwriteException? _brokerDisconnectError(MqttClient mqtt) {
  final status = mqtt.connectionStatus;
  if (status == null ||
      status.disconnectionOrigin != MqttDisconnectionOrigin.brokerSolicited) {
    return null;
  }
  final disconnect = status.disconnectMessage;
  final code = disconnect.reasonCode;
  if (code == null ||
      code == MqttDisconnectReasonCode.notSet ||
      code == MqttDisconnectReasonCode.normalDisconnection) {
    return null;
  }
  final reason = disconnect.reasonString;
  return AppwriteException(
    reason != null && reason.isNotEmpty
        ? reason
        : 'Disconnected by the broker (reason ${MqttDisconnectReasonCodeSupport.mqttDisconnectReasonCode.asInt(code)})',
  );
}

/// Reports failed automatic reconnects, which mqtt5_client retries internally without
/// throwing: a refused CONNECT (with the broker's Reason String) as soon as its CONNACK
/// arrives, any other failure when the next attempt starts.
class _ReconnectWatch {
  final MqttClient _mqtt;
  final void Function(Object error) _report;
  Timer? _timer;
  bool _attempting = false;
  bool _attemptReported = false;

  _ReconnectWatch(this._mqtt, this._report);

  void attemptStarted() {
    if (_attempting && !_attemptReported) {
      _report(AppwriteException('Push reconnect attempt failed'));
    }
    _attempting = true;
    _attemptReported = false;
    // Forget the last CONNACK so an earlier refusal is not reported for this attempt.
    _mqtt.connectionStatus?.reasonCode = MqttConnectReasonCode.notSet;
    _timer ??= Timer.periodic(const Duration(milliseconds: 50), (_) {
      final status = _mqtt.connectionStatus;
      if (_attempting && !_attemptReported && _refused(status)) {
        _attemptReported = true;
        _report(AppwriteException(_refusalMessage(status!)));
      }
    });
  }

  void stop() {
    _attempting = false;
    _timer?.cancel();
    _timer = null;
  }
}

/// A hex id, uuid4-like enough for a client-generated subId / client id suffix.
String _randomId() {
  final random = Random();
  final buffer = StringBuffer();
  for (var i = 0; i < 32; i++) {
    buffer.write(random.nextInt(16).toRadixString(16));
  }
  return buffer.toString();
}

/// MQTT topic-filter match with '+' (single level) and '#' (multi level).
bool _matches(String filter, String topic) {
  final filterParts = filter.split('/');
  final topicParts = topic.split('/');
  for (var i = 0; i < filterParts.length; i++) {
    final part = filterParts[i];
    if (part == '#') {
      return true;
    }
    if (i >= topicParts.length) {
      return false;
    }
    if (part != '+' && part != topicParts[i]) {
      return false;
    }
  }
  return filterParts.length == topicParts.length;
}

/// Resolve [Push.subscribe]'s `topics`: a String, Topic or ResolvedTopic, or a List of
/// them, or null for the signed-in user's own `users/<userId>` topic.
List<String> _topicList(Client client, Object? topics) {
  if (topics == null) {
    return <String>[_userTopic(client)];
  }
  // A topic is a String or a Topic / ResolvedTopic builder (via toString()).
  return topics is List
      ? topics.map((topic) => topic.toString()).toList()
      : <String>[topics.toString()];
}

/// The signed-in user's own topic, `users/<userId>`, read off the client's
/// credential (JWT first, then session) without a network call.
String _userTopic(Client client) {
  final jwt = client.config['jwt'] ?? client.config['jWT'];
  final session = client.config['session'];
  // The credential the connection authenticates with: the JWT when one is set (never the
  // session, which could belong to a different user), else the session.
  final userId =
      (jwt != null && jwt.isNotEmpty)
          ? _userIdFromJwt(jwt)
          : _userIdFromSession(session);
  if (userId == null) {
    throw AppwriteException(
      'subscribe() without a topic needs a signed-in user: set a JWT or session on the client',
    );
  }
  return 'users/$userId';
}

/// The `userId` claim of a JWT's payload, or null when it has none.
String? _userIdFromJwt(String? jwt) {
  final parts = jwt?.split('.') ?? const <String>[];
  if (parts.length < 2) {
    return null;
  }
  return _stringField(parts[1], 'userId');
}

/// The user id inside a session secret, which is base64 of JSON
/// `{"id": <userId>, "secret": ...}`, or null when it is not such a secret.
String? _userIdFromSession(String? session) {
  if (session == null || session.isEmpty) {
    return null;
  }
  return _stringField(session, 'id');
}

/// Decode base64 (standard or url-safe) JSON and read a non-empty string [key].
String? _stringField(String encoded, String key) {
  try {
    final json = jsonDecode(
      utf8.decode(base64.decode(base64.normalize(encoded))),
    );
    final value = json is Map ? json[key] : null;
    return value is String && value.isNotEmpty ? value : null;
  } catch (_) {
    return null;
  }
}

class _Superseded implements Exception {
  const _Superseded();
}
