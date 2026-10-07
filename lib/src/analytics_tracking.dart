import 'package:flutter/widgets.dart';

import 'analytics_observer.dart';

export 'analytics_observer.dart' show AnalyticsEventEmitter, AnalyticsObserver, ScreenNameExtractor;

/// Companion class for the generated `Analytics` service that wires up the
/// mobile-idiomatic auto-tracking primitives: app-lifecycle events (backgrounded
/// / foregrounded) and manual `screenView` calls.
///
/// Auto-emitted event names follow `snake_case` + lowercase (`pageview`,
/// `screen_view`, `app_backgrounded`, `app_foregrounded`, etc.). Prop keys use
/// camelCase to match the endpoint's parameter naming.
///
/// Attach an [AnalyticsObserver] to your `MaterialApp` for automatic route
/// tracking; use [AnalyticsTracking] on top for lifecycle events and the
/// convenience `screenView` / `event` shortcuts.
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
/// final analytics = Analytics(client);
///
/// // `createEvent` requires `url` and takes `props` as a flat alternating
/// // key/value list, so the emitter adapts this module's option shape.
/// void emit(String name, {Map<String, dynamic>? props, String? propertyId, int? engagementTime}) =>
///     analytics.createEvent(
///       propertyId: propertyId ?? '<PROPERTY_ID>',
///       name: name,
///       url: '<APP_URL>',
///       engagementTime: engagementTime,
///       props: (props ?? const {})
///           .entries
///           .expand((entry) => [entry.key, '${entry.value}'])
///           .toList(),
///     );
///
/// final tracking = AnalyticsTracking(emit, propertyId: '<PROPERTY_ID>');
/// tracking.enableAllAutoTracking();
///
/// runApp(MaterialApp(
///   navigatorObservers: [
///     AnalyticsObserver(emit, propertyId: '<PROPERTY_ID>'),
///   ],
///   home: MyApp(),
/// ));
/// ```
class AnalyticsTracking with WidgetsBindingObserver {
  final AnalyticsEventEmitter _emit;

  /// Analytics property (or snippet) ID forwarded with every emitted event.
  /// Optional — leave null when the emitter closure already supplies one.
  final String? propertyId;

  bool _lifecycleAttached = false;
  DateTime? _foregroundSince;

  /// Sub-second engagement left over from the previous flush. Carried forward
  /// so a session made of many short foreground stretches does not lose a
  /// fraction of a second to truncation on every one of them.
  Duration _engagementCarry = Duration.zero;

  AnalyticsTracking(AnalyticsEventEmitter emit, {this.propertyId}) : _emit = emit;

  /// Enable the opinionated default auto-tracking set. Currently this covers
  /// lifecycle events; route tracking is opt-in via [AnalyticsObserver].
  void enableAllAutoTracking() {
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

  /// Emit an ad-hoc analytics event. Emitter exceptions are swallowed so
  /// analytics failures never surface to the host app.
  void event(
    String name, {
    Map<String, dynamic>? props,
    int? engagementTime,
  }) {
    try {
      _emit(
        name,
        props: props,
        propertyId: propertyId,
        engagementTime: engagementTime,
      );
    } catch (_) {
      // Silent — see class docs.
    }
  }

  /// Mobile-idiomatic screen-view shortcut. Renders as a `screen_view`
  /// analytics event with `screen`, optional `screenClass` and any
  /// caller-supplied properties.
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
    event('screen_view', props: merged);
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
        _foregroundSince = DateTime.now();
        event('app_foregrounded');
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }
}
