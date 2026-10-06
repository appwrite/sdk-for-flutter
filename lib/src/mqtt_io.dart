import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:typed_data/typed_data.dart' as typed;
import 'client.dart';
import 'exception.dart';
import 'mqtt.dart';
import 'mqtt_foreground.dart';
import 'mqtt_message.dart';
import 'mqtt_native.dart';

Push createPush(Client client) => PushIO(client);

class _Subscription {
  final String filter;
  final PushCallback callback;
  bool background;
  String? title;
  bool retry;

  _Subscription(
    this.filter,
    this.callback, {
    this.background = false,
    this.title,
    this.retry = true,
  });
}

class _SubscriptionHandle implements PushSubscription {
  final void Function() _unsubscribe;
  final void Function({bool? background, String? title, bool? retry}) _update;

  _SubscriptionHandle(this._unsubscribe, this._update);

  @override
  void unsubscribe() => _unsubscribe();

  @override
  void update({bool? background, String? title, bool? retry}) =>
      _update(background: background, title: title, retry: retry);
}

// Fixed connection tuning — not exposed as an option.
const int _keepAliveSeconds = 60;

class PushIO implements Push {
  @override
  final Client client;

  final String _host;
  final int _port;
  final bool _tls;
  final bool _tlsInsecure;

  MqttServerClient? _mqtt;
  Future<void>? _connecting;

  void Function()? _onOpen;
  void Function()? _onClose;
  void Function(Object error)? _onError;

  // Resolved once per instance: a reconnect rebuilds the client, and if each rebuild drew a
  // new random id the broker would treat it as a new session and drop this client's replay
  // cursor. A stable id from Client.setPushClientId() resumes replay across restarts;
  // otherwise a per-instance id is generated. Reusing one id keeps the session stable.
  late final String _resolvedClientId = _pushClientId();

  // Whether the connection currently lives in the background isolate (foreground service)
  // rather than in-process. The connection relocates there while any subscription wants
  // background delivery, and back in-process once none do — one connection either way, so
  // the broker never sees two sessions with the same client id.
  bool _isolateActive = false;
  StreamSubscription<Map<String, dynamic>?>? _serviceListener;
  StreamSubscription<Map<String, dynamic>?>? _serviceErrorListener;

  // On Android the native plugin hosts background delivery instead of the isolate, on the same
  // core as the Android SDK. Null elsewhere.
  final PushNative? _native = PushNative.instance;
  // Whether the subscriptions currently live on the native plugin's connection.
  bool _nativeActive = false;
  // Bumped when the subscriptions move to the native host, or the credential changes,
  // superseding an _open in flight.
  int _connectionEpoch = 0;
  Completer<void>? _openCancel;
  String _connectedKey = '';
  bool _resubscribeOnConnect = false;
  StreamSubscription<Map<Object?, Object?>>? _nativeListener;

  // Every Push on Android shares the one native host (one connection per client id), which hosts
  // the union of their subscriptions. Native calls run one at a time in call order, so a sign-out
  // is never undone by a subscribe still on its way.
  static final Set<PushIO> _nativeHosts = {};
  // Every Push with live subscriptions, so the native host can take over their connections.
  static final Set<PushIO> _livePushes = {};
  static Future<void> _nativeQueue = Future<void>.value();

  static Future<T> _enqueueNative<T>(Future<T> Function() op) {
    final result = _nativeQueue.then((_) => op());
    _nativeQueue = result.then((_) {}, onError: (Object _) {});
    return result;
  }

  // Serializes background config writes (topic/notify syncs and stops). Each write is a
  // file write plus a service event, so unserialized rapid calls could interleave and apply
  // out of order. Chaining runs them in call order; each reads the current state when it
  // runs, so the last requested value always wins.
  Future<void> _backgroundSync = Future<void>.value();

  // Local id -> subscription (filter + callback + per-sub options). The id is never sent to
  // the broker; it only lets the same topic carry more than one callback.
  final Map<String, _Subscription> _subscriptions = {};
  // topic filter -> FIFO queue of completers resolved on each SUBACK. A queue (not a
  // single completer) so two concurrent subscribes to the same topic both resolve.
  final Map<String, List<Completer<void>>> _subAcks = {};

  factory PushIO(Client client) {
    // The broker location comes from Client.setPushEndpoint() when set (e.g.
    // "mqtts://host:8883"), otherwise from the regular endpoint.
    final pushEndpoint = client.config['endpointPush'] ?? client.endPoint;
    // Secure by default: TLS on when the endpoint scheme is secure, so the credential in the
    // CONNECT packet is not sent over a plaintext socket.
    final resolvedTls = _secureScheme(pushEndpoint);
    final resolvedPort =
        _pushEndpointPort(client) ?? (resolvedTls ? 8883 : 1883);
    // When no explicit push endpoint is set, default to a `push.` host on the regular
    // endpoint (mirroring how realtime derives from the endpoint, on the push subdomain).
    final resolvedHost =
        client.config['endpointPush'] != null
            ? _hostOf(pushEndpoint)
            : 'push.${_hostOf(pushEndpoint)}';
    return PushIO._(
      client,
      host: resolvedHost,
      port: resolvedPort,
      tls: resolvedTls,
      tlsInsecure: _insecureFlag(client),
    );
  }

  PushIO._(
    this.client, {
    required String host,
    required int port,
    required bool tls,
    required bool tlsInsecure,
  }) : _host = host,
       _port = port,
       _tls = tls,
       _tlsInsecure = tlsInsecure {
    // Resume background delivery saved by an earlier run now, instead of at its next
    // scheduled wake-up.
    unawaited(_native?.resume().catchError(_report));
  }

  // Empty when the app did not set one: the broker derives a stable id server-side (keyed on
  // the credential/project) so the replay cursor resumes across restarts.
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

  // Skip TLS cert verification (self-signed brokers / testing) via a query flag on the push
  // endpoint, e.g. "mqtts://host:8883?tlsInsecure=true" — so the whole connection is
  // described by one URL, not a second config knob.
  static bool _insecureFlag(Client client) {
    final endpoint = client.config['endpointPush'];
    if (endpoint == null) {
      return false;
    }
    try {
      final value = Uri.parse(endpoint).queryParameters['tlsInsecure'];
      return value == 'true' || value == '1';
    } catch (_) {
      return false;
    }
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
    // On Android, a refused credential that stopped background delivery while no callback
    // was registered is delivered now.
    final native = _native;
    if (native != null) {
      unawaited(() async {
        try {
          final stopped = await native.setErrorCallback(true);
          if (stopped != null) {
            _report(AppwriteException(stopped));
          }
        } catch (e) {
          _report(e);
        }
      }());
    }
    return this;
  }

  @override
  Future<void> setForeground(bool enabled) async {
    await _native?.setForeground(enabled);
  }

  // Errors already handed to onError, so one failure reaching it through two paths (a
  // refused CONNACK that also fails the subscribe waiting on it) is reported once.
  final Expando<bool> _reported = Expando<bool>();

  // Every error the service hits goes through here and reaches onError. It is never thrown
  // from here, so an error outside any call cannot crash the app.
  void _report(Object error) {
    if (error is _Superseded) {
      // Internal: a connection superseded by the native host, not a failure.
      return;
    }
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
  }) async {
    final List<String> topicList;
    try {
      topicList = _topicList(client, topics);
    } catch (e) {
      _notify(e);
      rethrow;
    }
    // The own-user topic (topics == null) defaults to background delivery, like FCM/APNs.
    final wantsBackground = background ?? topics == null;
    _livePushes.add(this);

    final ids = <String>[];
    for (final topic in topicList) {
      final id = _randomId();
      ids.add(id);
      _subscriptions[id] = _Subscription(
        topic,
        callback,
        background: wantsBackground,
        title: title,
        retry: retry,
      );
    }

    try {
      final native = _native;
      if (native != null &&
          (_backgroundWanted ||
              _nativeHosts.isNotEmpty ||
              await native.hasSaved())) {
        // Android: the native plugin hosts the single connection while any subscription, live
        // or saved by an earlier run, wants background.
        await _hostNative();
      } else if (_backgroundWanted) {
        // Any sub wants background: the isolate hosts the single connection (relocating
        // off the in-process one if it was up) and covers the whole topic union.
        await _hostInIsolate();
      } else {
        while (true) {
          try {
            await _subscribeInProcess(ids);
            break;
          } on _Superseded {
            // Another Push moved this one's subscriptions to the native host meanwhile: this
            // subscribe goes there too.
            if (_nativeActive) {
              await _hostNative();
              break;
            }
          }
        }
      }
    } catch (e) {
      for (final id in ids) {
        _subscriptions.remove(id);
      }
      // Return to a consistent host for whatever subscriptions remain.
      _reconcile();
      _notify(e);
      rethrow;
    }

    return _SubscriptionHandle(
      () => _unsubscribeIds(ids),
      ({bool? background, String? title, bool? retry}) =>
          _updateIds(ids, background: background, title: title, retry: retry),
    );
  }

  // In-process host: connect and register this call's new filters, awaiting each SUBACK.
  Future<void> _subscribeInProcess(List<String> ids) async {
    final mqtt = await _connect();
    final acks = <Future<void>>[];
    for (final id in ids) {
      final sub = _subscriptions[id];
      if (sub == null) {
        continue;
      }
      final completer = Completer<void>();
      (_subAcks[sub.filter] ??= <Completer<void>>[]).add(completer);
      acks.add(completer.future);
      mqtt.subscribeWithSubscriptionList([
        MqttSubscription.withMaximumQos(
          MqttSubscriptionTopic(sub.filter),
          _effectiveQos(sub.filter),
        ),
      ]);
    }
    // The broker only starts routing a topic once its subscription is registered, so
    // publishing before the SUBACK races the message ahead of it. Awaiting makes it reliable.
    await Future.wait(acks);
  }

  // Host every subscription of every Push on the native plugin's connection (Android), closing
  // this one's in-process connection. Completes once the connection is up and every filter is
  // subscribed (SUBACK), or throws why not.
  Future<void> _hostNative() {
    final native = _native!;
    final key = _credentialKey;
    // The native host carries one connection, so it serves one credential: instances hosted for
    // another move back to their own connection. Instances with this credential share its client
    // id, so their in-process connections would take over the broker session: they move to the
    // native host too.
    for (final push in _nativeHosts.toList()) {
      if (push._credentialKey != key) {
        push._leaveToInProcess();
        if (push._backgroundWanted) {
          push._report(AppwriteException(_backgroundDisplaced));
        }
      }
    }
    // Once moved, they stay: if hosting fails, the native host keeps their subscriptions and
    // retries on its scheduled runs, and a second connection with the same client id would take
    // over its broker session.
    for (final push in _livePushes.toList()) {
      if (push._subscriptions.isNotEmpty && push._credentialKey == key) {
        push._joinNative(native);
      }
    }
    _joinNative(native);
    return _enqueueNative(() => _sendToNative(native));
  }

  // Host every native host's subscriptions with this Push's credential.
  Future<void> _sendToNative(PushNative native) async {
    // Host what is subscribed when this runs, so a close() or an unsubscribe queued meanwhile
    // is not undone by an older request.
    final subscriptions = [
      for (final push in _nativeHosts) ...push._nativeEntries,
    ];
    if (subscriptions.isEmpty) {
      return;
    }
    final (authMethod, credential) = _credential();
    final config = {
      'host': _host,
      'port': _port,
      'tls': _tls,
      'tlsInsecure': _tlsInsecure,
      'clientId': _resolvedClientId,
      'authMethod': authMethod,
      'credential': credential,
      'project': client.config['project'] ?? '',
    };
    await native.setErrorCallback(
      _nativeHosts.any((push) => push._onError != null),
    );
    await native.host(jsonEncode(config), jsonEncode(subscriptions));
  }

  // Move this Push's subscriptions onto the native host, closing its own connection.
  void _joinNative(PushNative native) {
    // An _open still in flight sees this and closes what it opened, and a subscribe still waiting
    // for its SUBACK continues on the native host.
    _dropConnection();
    _nativeListener ??= native.listen(
      onMessage: (message) {
        final sub = _subscriptions[message.id];
        if (sub == null) {
          return;
        }
        try {
          sub.callback(
            PushMessage(
              topic: message.topic,
              payload: message.payload,
              qos: message.qos,
            ),
          );
        } catch (e) {
          _report(e);
        }
        // Acknowledged once its callback has run, as on the in-process connection.
        unawaited(native.ack(message.ackToken).catchError(_report));
      },
      onError: (message) => _report(AppwriteException(message)),
    );
    _nativeHosts.add(this);
    _nativeActive = true;
  }

  void _dropConnection() {
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
    if (_mqtt != null) {
      _mqtt?.disconnect();
      _mqtt = null;
    }
  }

  // Move this Push's subscriptions back onto its own connection.
  void _leaveToInProcess() {
    _nativeHosts.remove(this);
    _nativeActive = false;
    unawaited(_ensureInProcessSubscribed().catchError(_report));
  }

  // Identifies the connection this Push authenticates: one native host serves one.
  String get _credentialKey {
    try {
      final (authMethod, credential) = _credential();
      return [
        _host,
        _port,
        client.config['project'] ?? '',
        _resolvedClientId,
        authMethod,
        credential,
      ].join('|');
    } catch (_) {
      return '';
    }
  }

  // This Push's subscriptions in the native plugin's format.
  List<Map<String, Object?>> get _nativeEntries => [
    for (final entry in _subscriptions.entries)
      {
        'id': entry.key,
        'topic': entry.value.filter,
        'background': entry.value.background,
        'title': entry.value.title,
        'retry': entry.value.retry,
      },
  ];

  // After an unsubscribe or update on Android: keep the native plugin hosting while any
  // subscription, live (of any Push) or saved, wants background, else move the live ones back
  // in-process.
  Future<void> _reconcileNative(PushNative native) async {
    if (_subscriptions.isEmpty) {
      // This Push has nothing left; saved subscriptions keep delivering in the background.
      if (_nativeActive) {
        await _leaveNative(native);
      }
      return;
    }
    final wanted =
        {..._nativeHosts, this}.any((push) => push._backgroundWanted) ||
        await native.hasSaved();
    if (wanted) {
      await _hostNative();
      return;
    }
    // Nothing wants background: every Push moves back to its own connection.
    final hosts = _nativeHosts.toList();
    _nativeHosts.clear();
    for (final push in hosts) {
      push._nativeActive = false;
    }
    await _enqueueNative(() => native.release());
    for (final push in {...hosts, this}) {
      if (push._subscriptions.isNotEmpty) {
        await push._ensureInProcessSubscribed();
      }
    }
  }

  // Stop hosting this Push natively; the others' subscriptions stay hosted.
  Future<void> _leaveNative(PushNative native) {
    _nativeHosts.remove(this);
    _nativeActive = false;
    if (_nativeHosts.isNotEmpty) {
      return _nativeHosts.first._hostNative();
    }
    return _enqueueNative(() => native.release());
  }

  // Relocate the connection into the background isolate and sync it with the current topic
  // union and per-subscription notification config.
  Future<void> _hostInIsolate() async {
    if (_mqtt != null) {
      _mqtt?.disconnect();
      _mqtt = null;
      _connecting = null;
    }
    _isolateActive = true;
    _attachServiceListener();
    await _syncBackground();
  }

  // Listen for messages the background isolate relays back and forward them to every
  // matching in-app callback (so callbacks still fire while the app is alive, background or
  // not). Idempotent.
  void _attachServiceListener() {
    _serviceListener ??= FlutterBackgroundService()
        .on(pushForegroundMessageEvent)
        .listen((data) {
          if (data == null) {
            return;
          }
          final topic = data['topic'] as String? ?? '';
          final payload = Uint8List.fromList(
            utf8.encode(data['payload'] as String? ?? ''),
          );
          final message = PushMessage(
            topic: topic,
            payload: payload,
            qos: data['qos'] as int? ?? 0,
          );
          for (final sub in _subscriptions.values) {
            if (_matches(sub.filter, topic)) {
              sub.callback(message);
            }
          }
        });
    // The isolate's own connection/subscribe errors, relayed as their message.
    _serviceErrorListener ??= FlutterBackgroundService()
        .on(pushForegroundErrorEvent)
        .listen((data) {
          _report(
            AppwriteException(
              data?['message'] as String? ?? 'Background push failed',
            ),
          );
        });
  }

  void _detachServiceListener() {
    _serviceListener?.cancel();
    _serviceListener = null;
    _serviceErrorListener?.cancel();
    _serviceErrorListener = null;
  }

  bool get _backgroundWanted => _subscriptions.values.any((s) => s.background);

  // The union of every subscription's filter (the isolate hosts one connection for all).
  List<String> get _backgroundTopics =>
      _subscriptions.values.map((s) => s.filter).toSet().toList();

  // filter -> notification title, for filters that have at least one background subscription
  // (those are the only ones that post a notification, each with its own title).
  Map<String, String> get _notifyConfig {
    final map = <String, String>{};
    for (final sub in _subscriptions.values) {
      if (sub.background) {
        map[sub.filter] = sub.title ?? _defaultTitle;
      }
    }
    return map;
  }

  String get _defaultTitle => 'Appwrite';

  // The broker subscription for a filter uses the highest QoS any subscription on it wants,
  // so a QoS-0 subscription never downgrades a QoS-1 one sharing the filter.
  MqttQos _effectiveQos(String filter) {
    final reliable = _subscriptions.values.any(
      (s) => s.filter == filter && s.retry,
    );
    return reliable ? MqttQos.atLeastOnce : MqttQos.atMostOnce;
  }

  // filter -> QoS (1 reliable / 0 not), handed to the isolate so it subscribes each topic
  // at the right level.
  Map<String, int> get _qosConfig {
    final map = <String, int>{};
    for (final filter in _backgroundTopics) {
      map[filter] = _effectiveQos(filter) == MqttQos.atLeastOnce ? 1 : 0;
    }
    return map;
  }

  // Run a background config write after any already-queued one, so writes never interleave
  // or reorder. The returned future carries this write's own result to its caller, while the
  // chain itself never rejects (a failed write must not stall later ones).
  Future<void> _enqueueBackground(Future<void> Function() op) {
    final result = _backgroundSync.then((_) => op());
    _backgroundSync = result.then((_) {}, onError: (Object _) {});
    return result;
  }

  // Sync the running/started isolate with the current topic union and notify config.
  Future<void> _syncBackground() => _enqueueBackground(() async {
    // Skip if background was turned off after this was queued, so a stale write can't
    // recreate the credential file after shutdown deleted it.
    if (!_backgroundWanted) {
      return;
    }
    await syncPushForeground(
      client,
      serviceTitle: _defaultTitle,
      topics: _backgroundTopics,
      notify: _notifyConfig,
      qos: _qosConfig,
    );
  });

  // Enqueue the background stop after any pending config write, so the credential file is
  // always deleted last — a write queued just before shutdown cannot recreate it afterwards.
  void _enqueueStop() {
    unawaited(
      _enqueueBackground(() async {
        // Skip if background is wanted again by the time this runs, so a stale stop can't
        // tear down a live connection or delete a credential config that is still in use.
        if (_backgroundWanted) {
          return;
        }
        await stopPushForeground();
      }).catchError(_report),
    );
  }

  // Ensure the correct host (in-process vs isolate) for whatever subscriptions remain, and
  // sync it. Called after an unsubscribe/update may have flipped whether background is wanted.
  void _reconcile() {
    final native = _native;
    if (native != null) {
      unawaited(_reconcileNative(native).catchError(_report));
      return;
    }
    if (_subscriptions.isEmpty) {
      return;
    }
    if (_backgroundWanted) {
      if (_mqtt != null) {
        _mqtt?.disconnect();
        _mqtt = null;
        _connecting = null;
      }
      _isolateActive = true;
      _attachServiceListener();
      unawaited(_syncBackground().catchError(_report));
    } else {
      if (_isolateActive) {
        _isolateActive = false;
        _detachServiceListener();
        _enqueueStop();
      }
      unawaited(_ensureInProcessSubscribed().catchError(_report));
    }
  }

  // Bring up the in-process connection and (re)register every filter — used when the last
  // background subscription goes away and the connection relocates back in-process. Nobody
  // awaits it, so a rejected SUBACK reaches onError through [_onSubscribeFail].
  Future<void> _ensureInProcessSubscribed() async {
    final mqtt = await _connect();
    for (final filter in _backgroundTopics) {
      mqtt.subscribeWithSubscriptionList([
        MqttSubscription.withMaximumQos(
          MqttSubscriptionTopic(filter),
          _effectiveQos(filter),
        ),
      ]);
    }
  }

  void _unsubscribeIds(List<String> ids) {
    // Filters whose removed sub was QoS 1: their effective QoS may now drop.
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
      if (entry != null && !stillUsed && _mqtt != null) {
        try {
          _mqtt?.unsubscribeStringTopic(entry.filter);
        } catch (e) {
          _report(e);
        }
      }
    }
    if (_subscriptions.isEmpty) {
      // The last live subscription is gone; on Android, saved ones keep delivering.
      _teardown();
      _reconcile();
      return;
    }
    // A removed sub may have been the last background one (relocate in-process) or just
    // change the isolate's topic/notify set (the isolate re-sync carries the new QoS map).
    _reconcile();
    // In-process, a filter that lost its last QoS-1 sub but still has QoS-0 subs must be
    // re-subscribed lower, or the broker keeps replaying to at-most-once subs.
    if (!_backgroundWanted && !_nativeActive && _mqtt != null) {
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
    }
  }

  void _updateIds(
    List<String> ids, {
    bool? background,
    String? title,
    bool? retry,
  }) {
    for (final id in ids) {
      final sub = _subscriptions[id];
      if (sub == null) {
        continue;
      }
      if (background != null) {
        sub.background = background;
      }
      if (title != null) {
        sub.title = title;
      }
      if (retry != null) {
        sub.retry = retry;
      }
    }
    // reconcile re-subscribes (in-process) / re-syncs the isolate at the new effective QoS.
    _reconcile();
  }

  /// Tear down the connection and drop all subscriptions. On Android, closing the last Push that
  /// uses background delivery also stops it, including subscriptions saved by an earlier run:
  /// call it on sign-out. While other Push instances still use it, it keeps delivering their
  /// subscriptions and the saved ones.
  @override
  void close() {
    _teardown();
    final native = _native;
    if (native == null) {
      return;
    }
    _nativeHosts.remove(this);
    _nativeActive = false;
    unawaited(_nativeListener?.cancel());
    _nativeListener = null;
    if (_nativeHosts.isNotEmpty) {
      final other = _nativeHosts.first;
      unawaited(other._hostNative().catchError(other._report));
      return;
    }
    unawaited(_enqueueNative(() => native.stop()).catchError(_report));
  }

  // Close the in-process connection (and the isolate host) and drop the live subscriptions.
  void _teardown() {
    _livePushes.remove(this);
    _mqtt?.disconnect();
    _mqtt = null;
    _connecting = null;
    _detachServiceListener();
    _subscriptions.clear();
    if (_isolateActive) {
      _isolateActive = false;
      _enqueueStop();
    }
  }

  Future<MqttServerClient> _connect() {
    if ((_mqtt != null || _connecting != null) &&
        _connectedKey != _credentialKey) {
      _dropConnection();
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

  Future<void> _open() async {
    final (authMethod, credential) = _credential();
    _connectedKey = _credentialKey;
    final epoch = _connectionEpoch;

    final project = client.config['project'] ?? '';
    // An empty client id makes the broker derive a stable id server-side (keyed on the
    // credential/project) and key its offline-replay cursor on it; Client.setPushClientId(id)
    // overrides with an explicit id. Resolved once per instance (see [_resolvedClientId]) so a
    // reconnect rebuild reuses the same id and resumes the same session.
    // On Android the native plugin's per-user-and-install id is used when none was set, so this
    // connection and the background one share the broker session.
    final native = _native;
    final clientId =
        _resolvedClientId.isEmpty && native != null
            ? await native.defaultClientId(authMethod, credential)
            : _resolvedClientId;
    // The subscriptions moved to the native host while this was waiting: its connection would
    // share the host's client id and take over the broker session.
    if (epoch != _connectionEpoch) {
      throw const _Superseded();
    }

    final mqtt = MqttServerClient.withPort(_host, clientId, _port);
    mqtt.keepAlivePeriod = _keepAliveSeconds;
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

    if (_tls) {
      mqtt.secure = true;
      if (_tlsInsecure) {
        mqtt.onBadCertificate = (dynamic certificate) => true;
      }
    }

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
      // Superseded by the native host, which closed this connection on purpose.
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
      for (final filter in _backgroundTopics) {
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
      for (final subscription in _subscriptions.values) {
        if (_matches(subscription.filter, topic)) {
          subscription.callback(message);
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
      // Nobody awaits this SUBSCRIBE (a resubscribe after reconnect, a QoS change or a
      // relocation back in-process), so onError is the only place it can surface.
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

// Reported to a Push whose background delivery stopped because a Push with another credential
// took over the native host, which carries one connection and so serves one credential.
const String _backgroundDisplaced =
    'Background delivery stopped: a Push with another credential started background delivery, '
    'and the device hosts one. These subscriptions still deliver while the app runs.';

// An in-process connect superseded by moving the subscriptions to the native host, or by a
// connect with another credential.
class _Superseded implements Exception {
  const _Superseded();
}
