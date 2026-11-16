import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../appwrite.dart' show Analytics;
import 'tracking_install_stub.dart'
    if (dart.library.io) 'tracking_install_io.dart';

part 'tracking_observer.dart';

/// Auto-tracking helpers for the generated [Analytics] service: install, update
/// and app-lifecycle events, push helpers, and manual `screenView` / `event`
/// calls, all sent through `Analytics.createEvent`.
///
/// Auto-emitted event names follow `snake_case` + lowercase (`screen_view`,
/// `app_backgrounded`, `app_foregrounded`, etc.). Prop keys use camelCase to
/// match the endpoint's parameter naming.
///
/// Attach a [TrackingObserver] to your `MaterialApp` for automatic route
/// tracking.
///
/// [enableAutoLifecycleEvents] calls [WidgetsFlutterBinding.ensureInitialized]
/// internally, so it is safe to invoke before [runApp] without wiring up the
/// binding manually. Callers who need the binding for their own initialization
/// (async setup, plugin channels, etc.) can still call `ensureInitialized()`
/// themselves — the call is idempotent.
///
/// Engagement time is reported the same way the Web helper reports it: as a
/// **delta** attached to each `app_backgrounded` event, covering only the
/// foreground time accrued since the last resume. Backgrounding is the mobile
/// equivalent of a browser tab going hidden, and it is where the Web helper
/// flushes too, so the two platforms feed the same additive `engagementTime`
/// column. The seconds ride on the lifecycle event that is already being sent
/// at that exact moment rather than adding a second request for a single
/// number.
///
/// Typical wiring:
///
/// ```dart
/// final tracking = Tracking(Analytics(client), '<PROPERTY_ID>');
/// tracking.start();
///
/// runApp(MaterialApp(
///   navigatorObservers: [TrackingObserver(tracking)],
///   home: MyApp(),
/// ));
/// ```
class Tracking with WidgetsBindingObserver {
  final Analytics _analytics;

  /// Analytics property every event is recorded against.
  final String propertyId;

  /// Base URL events are reported under; screen names resolve against it.
  /// Defaults to the page origin on Flutter web and `app://<platform>`
  /// elsewhere, since the endpoint only accepts absolute URLs.
  final String url;

  bool _lifecycleAttached = false;

  /// Runs while the app is in the foreground; monotonic, so a wall-clock change
  /// cannot skew engagement.
  Stopwatch? _foreground;

  /// Sub-second engagement left over from the previous flush. Carried forward
  /// so a session made of many short foreground stretches does not lose a
  /// fraction of a second to truncation on every one of them.
  Duration _engagementCarry = Duration.zero;

  Tracking(Analytics analytics, this.propertyId, {String? url})
    : _analytics = analytics,
      url =
          url ??
          (kIsWeb
              ? Uri.base.origin
              : 'app://${defaultTargetPlatform.name.toLowerCase()}');

  /// Start the default auto-tracking set: app-lifecycle events, as
  /// [enableAutoLifecycleEvents], plus `first_open` and `app_updated`. Route
  /// tracking is opt-in via [TrackingObserver].
  ///
  /// `first_open` is sent once per install, `app_updated` (with
  /// `previousVersion` and `version`) on the first start after the app's version
  /// changes. Both rely on a marker file in the app documents directory, so a
  /// reinstall or "clear data" counts as a new install. An existing install
  /// upgrading to this SDK is not counted when the client has saved cookies;
  /// without them its first start after the upgrade counts once. Neither event
  /// is sent on the web.
  ///
  /// The event is saved until the endpoint accepts it, so a failed send is
  /// retried on the next app start. A crash between the send and clearing it
  /// can send it twice. The check runs once per process, whatever the number of
  /// [Tracking] instances or [start] calls.
  void start() {
    enableAutoLifecycleEvents();
    unawaited(_installCheck ??= _trackInstall());
  }

  static Future<void>? _installCheck;

  /// The install check [start] runs, for tests to await.
  @visibleForTesting
  static Future<void>? get debugInstallCheck => _installCheck;

  /// Let the next [start] run the install check again, for tests.
  @visibleForTesting
  static void debugResetInstallCheck() => _installCheck = null;

  Future<void> _trackInstall() async {
    try {
      var pending = await readPendingInstallEvent();
      if (pending != null) {
        final version = (await PackageInfo.fromPlatform()).version;
        final install = jsonDecode(pending) as Map<String, dynamic>;
        final props = install['props'] as Map<String, dynamic>?;
        // Rolled back to the version an unsent update started from: nothing
        // changed. Marker first, so a crash in between repeats this branch.
        if (install['name'] == 'app_updated' &&
            props?['previousVersion'] == version) {
          await writeInstallMarker(version);
          await writePendingInstallEvent(null);
          return;
        }
        // An unsent update followed by another one is reported as a single
        // update from the old version to this one.
        if (install['name'] == 'app_updated' &&
            props != null &&
            props['version'] != version) {
          props['version'] = version;
          pending = jsonEncode(install);
          await writePendingInstallEvent(pending);
        }
        // A crash between the two writes below leaves the marker stale.
        await writeInstallMarker(version);
        await _sendPending(pending);
        return;
      }
      // Before the marker: the app's first request can save cookies meanwhile.
      final ranBefore = await sdkRanBefore();
      final saved = await readInstallMarker();
      final version = (await PackageInfo.fromPlatform()).version;
      if (saved == version) {
        return;
      }
      final Map<String, dynamic>? install = saved != null
          ? {
              'name': 'app_updated',
              'props': {'previousVersion': saved, 'version': version},
            }
          : ranBefore
          ? null
          : {'name': 'first_open'};
      if (install == null) {
        await writeInstallMarker(version);
        return;
      }
      // Saved before the marker and the send, so neither a crash nor a failed
      // send loses it.
      final json = jsonEncode(install);
      await writePendingInstallEvent(json);
      await writeInstallMarker(version);
      await _sendPending(json);
    } catch (_) {
      // Analytics never surface errors to the host app.
    }
  }

  Future<void> _sendPending(String json) async {
    final pending = jsonDecode(json) as Map<String, dynamic>;
    final sent = await _send(
      pending['name'] as String,
      props: pending['props'] as Map<String, dynamic>?,
      interactive: false,
    );
    if (sent) {
      await writePendingInstallEvent(null);
    }
  }

  /// Start emitting `app_backgrounded` and `app_foregrounded` events when the
  /// host app changes lifecycle state. Idempotent — repeat calls no-op.
  ///
  /// Calls [WidgetsFlutterBinding.ensureInitialized] internally so this is
  /// safe to invoke before [runApp] without the caller having to bootstrap
  /// the binding themselves.
  void enableAutoLifecycleEvents() {
    if (_lifecycleAttached) {
      return;
    }
    // WidgetsBinding.instance throws StateError if the binding has not been
    // set up yet. The docstring example wires this call before runApp(), so
    // ensure the binding here — the call is idempotent.
    WidgetsFlutterBinding.ensureInitialized();
    _lifecycleAttached = true;
    // A process launched in the background (a push, a background fetch) is
    // not engagement: its first real foreground sends `app_foregrounded`.
    final state = WidgetsBinding.instance.lifecycleState;
    _foreground =
        state == null ||
            state == AppLifecycleState.resumed ||
            state == AppLifecycleState.inactive
        ? (Stopwatch()..start())
        : null;
    _engagementCarry = Duration.zero;
    WidgetsBinding.instance.addObserver(this);
  }

  /// Stop emitting lifecycle events. Safe to call when auto-lifecycle was
  /// never enabled.
  void disableAutoLifecycleEvents() {
    if (!_lifecycleAttached) {
      return;
    }
    _lifecycleAttached = false;
    _foreground = null;
    _engagementCarry = Duration.zero;
    WidgetsBinding.instance.removeObserver(this);
  }

  /// Emit an ad-hoc analytics event. [url] may be absolute or a path resolved
  /// against [Tracking.url]. Request failures are swallowed so analytics never
  /// surface errors to the host app.
  void event(
    String name, {
    String? url,
    Map<String, dynamic>? props,
    int? engagementTime,
    bool? interactive,
  }) {
    unawaited(
      _send(
        name,
        url: url,
        props: props,
        engagementTime: engagementTime,
        interactive: interactive,
      ),
    );
  }

  // [event], awaitable: completes with whether the endpoint accepted the event.
  Future<bool> _send(
    String name, {
    String? url,
    Map<String, dynamic>? props,
    int? engagementTime,
    bool? interactive,
  }) async {
    try {
      await _analytics.createEvent(
        propertyId: propertyId,
        name: name,
        url: url == null
            ? this.url
            : Uri.parse(this.url).resolve(url).toString(),
        screenWidth: _viewportWidth(),
        engagementTime: engagementTime,
        interactive: interactive,
        // The endpoint takes props as a flat alternating key/value list.
        props: props?.entries
            .where((entry) => entry.value != null)
            .expand((entry) => [entry.key, '${entry.value}'])
            .toList(),
      );
      return true;
    } catch (_) {
      // Request failures, and a malformed [url] that throws before it starts.
      return false;
    }
  }

  // The endpoint buckets this as viewport width in logical pixels, matching
  // the Web helper's `innerWidth`, so physical width is divided by the ratio.
  int? _viewportWidth() {
    final view = PlatformDispatcher.instance.implicitView;
    if (view == null || view.physicalSize.width == 0) {
      return null;
    }
    return (view.physicalSize.width / view.devicePixelRatio).round();
  }

  /// Mobile-idiomatic screen-view shortcut. Renders as a `screen_view`
  /// analytics event with `screen`, optional `screenClass` and any
  /// caller-supplied properties. [name] is also the event URL's path.
  void screenView(
    String name, {
    String? className,
    Map<String, dynamic>? props,
  }) {
    _screenEvent('screen_view', name, className: className, props: props);
  }

  // Shared with [TrackingObserver], so its events carry the same props.
  void _screenEvent(
    String eventName,
    String name, {
    String? className,
    Map<String, dynamic>? props,
  }) {
    event(
      eventName,
      url: name,
      props: {'screen': name, 'screenClass': ?className, ...?props},
    );
  }

  /// Send `push_received` for a push notification the device got. Call it from
  /// your push handler; best effort, since on iOS, and on Android while the app
  /// is killed, the app's code often does not run when a notification arrives.
  /// [messageId] is the Appwrite Messaging message id.
  void pushReceived({String? messageId, String? campaign}) {
    event(
      'push_received',
      props: _pushProps(messageId, campaign),
      interactive: false,
    );
  }

  /// Send `push_opened` when the user taps a push notification. [messageId] is
  /// the Appwrite Messaging message id.
  void pushOpened({String? messageId, String? campaign}) {
    event(
      'push_opened',
      props: _pushProps(messageId, campaign),
      interactive: true,
    );
  }

  Map<String, dynamic> _pushProps(String? messageId, String? campaign) => {
    'messageId': ?messageId,
    'campaign': ?campaign,
  };

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        // On Flutter desktop and web the lifecycle transitions through both
        // `hidden` and `paused` when the window is minimised / closed. Guard
        // on `_foreground` so we emit `app_backgrounded` exactly once
        // per background transition instead of firing a second empty event —
        // which is also what keeps the engagement delta from being billed
        // twice for one transition.
        final foreground = _foreground;
        if (foreground == null) {
          break;
        }
        _foreground = null;
        final elapsed = _engagementCarry + foreground.elapsed;
        final seconds = elapsed.inSeconds;
        _engagementCarry = elapsed - Duration(seconds: seconds);
        event(
          'app_backgrounded',
          engagementTime: seconds > 0 ? seconds : null,
          interactive: false,
        );
        break;
      case AppLifecycleState.resumed:
        // `inactive` -> `resumed` (notification shade, app switcher preview)
        // never reaches `hidden`/`paused`, so the interval is still open.
        // Restarting it would discard the engagement accrued before the
        // interruption and emit a foreground event for no background.
        if (_foreground != null) {
          break;
        }
        _foreground = Stopwatch()..start();
        event('app_foregrounded', interactive: false);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }
}
