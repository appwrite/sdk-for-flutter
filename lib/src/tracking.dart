import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../appwrite.dart' show Analytics;

/// Auto-tracking helpers for the generated [Analytics] service: app-lifecycle
/// events (backgrounded / foregrounded) and manual `screenView` / `event`
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
  DateTime? _foregroundSince;

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
  /// [enableAutoLifecycleEvents]. Route tracking is opt-in via
  /// [TrackingObserver].
  void start() {
    enableAutoLifecycleEvents();
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
    _foregroundSince = DateTime.now();
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
    _foregroundSince = null;
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
  }) {
    try {
      unawaited(
        _analytics
            .createEvent(
              propertyId: propertyId,
              name: name,
              url:
                  url == null
                      ? this.url
                      : Uri.parse(this.url).resolve(url).toString(),
              engagementTime: engagementTime,
              // The endpoint takes props as a flat alternating key/value list.
              props:
                  props?.entries
                      .expand((entry) => [entry.key, '${entry.value}'])
                      .toList(),
            )
            .catchError((Object _) {}),
      );
    } catch (_) {
      // A malformed [url] throws before the request starts.
    }
  }

  /// Mobile-idiomatic screen-view shortcut. Renders as a `screen_view`
  /// analytics event with `screen`, optional `screenClass` and any
  /// caller-supplied properties. [name] is also the event URL's path.
  void screenView(
    String name, {
    String? className,
    Map<String, dynamic>? props,
  }) {
    final merged = <String, dynamic>{'screen': name};
    if (className != null) {
      merged['screenClass'] = className;
    }
    if (props != null) {
      merged.addAll(props);
    }
    event('screen_view', url: name, props: merged);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        // On Flutter desktop and web the lifecycle transitions through both
        // `hidden` and `paused` when the window is minimised / closed. Guard
        // on `_foregroundSince` so we emit `app_backgrounded` exactly once
        // per background transition instead of firing a second empty event —
        // which is also what keeps the engagement delta from being billed
        // twice for one transition.
        final since = _foregroundSince;
        if (since == null) {
          break;
        }
        _foregroundSince = null;
        final elapsed = _engagementCarry + DateTime.now().difference(since);
        final seconds = elapsed.inSeconds;
        _engagementCarry = elapsed - Duration(seconds: seconds);
        event(
          'app_backgrounded',
          engagementTime: seconds > 0 ? seconds : null,
        );
        break;
      case AppLifecycleState.resumed:
        // `inactive` -> `resumed` (notification shade, app switcher preview)
        // never reaches `hidden`/`paused`, so the interval is still open.
        // Restarting it would discard the engagement accrued before the
        // interruption and emit a foreground event for no background.
        if (_foregroundSince != null) {
          break;
        }
        _foregroundSince = DateTime.now();
        event('app_foregrounded');
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }
}
