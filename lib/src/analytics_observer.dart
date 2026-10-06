import 'package:flutter/widgets.dart';

/// Signature used to emit an analytics event from an [AnalyticsObserver] or
/// [AnalyticsTracking] instance.
///
/// The generated `Analytics` service exposes
/// `createEvent({required String propertyId, required String name, required String url, ...})`,
/// so the typical wiring is:
///
/// ```dart
/// final analytics = Analytics(client);
/// final observer = AnalyticsObserver(
///   (name, {props, propertyId, engagementTime}) => analytics.createEvent(
///     propertyId: propertyId ?? '<PROPERTY_ID>',
///     name: name,
///     url: '<APP_URL>',
///     engagementTime: engagementTime,
///     props: (props ?? const {})
///         .entries
///         .expand((entry) => [entry.key, '${entry.value}'])
///         .toList(),
///   ),
///   propertyId: '<PROPERTY_ID>',
/// );
/// ```
///
/// [propertyId] and [engagementTime] map to the endpoint's top-level params of
/// the same name; both are null unless the helper has something to say about
/// them, so a closure is free to ignore either.
typedef AnalyticsEventEmitter = void Function(
  String name, {
  Map<String, dynamic>? props,
  String? propertyId,
  int? engagementTime,
});

/// Signature used to derive a screen name from a [Route].
///
/// Return `null` to skip tracking the route entirely (for example, dialogs or
/// bottom sheets that shouldn't count as screen views).
typedef ScreenNameExtractor = String? Function(Route<dynamic> route);

/// Default [ScreenNameExtractor] — uses [RouteSettings.name] when present and
/// falls back to `null` (route is skipped) otherwise. Anonymous routes are
/// generally noise for analytics, so opting out by default keeps dashboards
/// clean.
String? defaultScreenNameExtractor(Route<dynamic> route) {
  return route.settings.name;
}

/// [NavigatorObserver] that fires an analytics event every time a named route
/// is pushed, popped-back-to, replaced or removed.
///
/// Attach to a `MaterialApp` (or `CupertinoApp`, `WidgetsApp`) via
/// `navigatorObservers`:
///
/// ```dart
/// MaterialApp(
///   navigatorObservers: [
///     AnalyticsObserver(
///       (name, {props, propertyId, engagementTime}) => analytics.createEvent(
///         propertyId: propertyId ?? '<PROPERTY_ID>',
///         name: name,
///         url: '<APP_URL>',
///         engagementTime: engagementTime,
///         props: (props ?? const {})
///             .entries
///             .expand((entry) => [entry.key, '${entry.value}'])
///             .toList(),
///       ),
///       propertyId: '<PROPERTY_ID>',
///     ),
///   ],
///   ...
/// );
/// ```
class AnalyticsObserver extends NavigatorObserver {
  /// Callback used to send the resulting `screen_view` event.
  final AnalyticsEventEmitter emit;

  /// Optional route-name extractor. Defaults to [defaultScreenNameExtractor]
  /// which reads [RouteSettings.name].
  final ScreenNameExtractor nameExtractor;

  /// Event name used for screen views. Defaults to `screen_view`.
  final String eventName;

  /// Analytics property (or snippet) ID forwarded with every emitted event.
  /// Optional — leave null when the emitter closure already supplies one.
  final String? propertyId;

  AnalyticsObserver(
    this.emit, {
    ScreenNameExtractor? nameExtractor,
    this.eventName = 'screen_view',
    this.propertyId,
  }) : nameExtractor = nameExtractor ?? defaultScreenNameExtractor;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _sendScreenView(route, previousRoute, trigger: 'push');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _sendScreenView(newRoute, oldRoute, trigger: 'replace');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      _sendScreenView(previousRoute, route, trigger: 'pop');
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      _sendScreenView(previousRoute, route, trigger: 'remove');
    }
  }

  void _sendScreenView(
    Route<dynamic> route,
    Route<dynamic>? previousRoute, {
    required String trigger,
  }) {
    final name = nameExtractor(route);
    if (name == null || name.isEmpty) {
      return;
    }
    final props = <String, dynamic>{
      'screen': name,
      'trigger': trigger,
    };
    final previousName = previousRoute == null ? null : nameExtractor(previousRoute);
    if (previousName != null && previousName.isNotEmpty) {
      props['previous'] = previousName;
    }
    try {
      emit(eventName, props: props, propertyId: propertyId);
    } catch (_) {
      // Emitter failures must never propagate into the navigator stack —
      // swallow so analytics can't crash the app.
    }
  }
}
