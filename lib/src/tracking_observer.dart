import 'package:flutter/widgets.dart';

import 'tracking.dart';

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

/// [NavigatorObserver] that fires an analytics event through a [Tracking]
/// every time a named route is pushed, popped-back-to, replaced or removed.
///
/// Attach to a `MaterialApp` (or `CupertinoApp`, `WidgetsApp`) via
/// `navigatorObservers`:
///
/// ```dart
/// MaterialApp(
///   navigatorObservers: [TrackingObserver(tracking)],
///   ...
/// );
/// ```
class TrackingObserver extends NavigatorObserver {
  /// Tracker the resulting `screen_view` events are sent through.
  final Tracking tracking;

  /// Optional route-name extractor. Defaults to [defaultScreenNameExtractor]
  /// which reads [RouteSettings.name].
  final ScreenNameExtractor nameExtractor;

  /// Event name used for screen views. Defaults to `screen_view`.
  final String eventName;

  TrackingObserver(
    this.tracking, {
    ScreenNameExtractor? nameExtractor,
    this.eventName = 'screen_view',
  }) : nameExtractor = nameExtractor ?? defaultScreenNameExtractor;

  /// The route the user is actually looking at. `didRemove` fires for buried
  /// routes too, and its `previousRoute` is the route below the removed one
  /// rather than the visible one, so the top has to be tracked explicitly.
  Route<dynamic>? _topRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _topRoute = route;
    _sendScreenView(route, previousRoute, trigger: 'push');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute == null) {
      return;
    }
    if (oldRoute != null && !identical(oldRoute, _topRoute)) {
      // A replace further down the stack leaves the visible screen alone.
      return;
    }
    _topRoute = newRoute;
    _sendScreenView(newRoute, oldRoute, trigger: 'replace');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _topRoute = previousRoute;
    if (previousRoute != null) {
      _sendScreenView(previousRoute, route, trigger: 'pop');
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (!identical(route, _topRoute)) {
      // Removing a buried route never changes what is on screen.
      return;
    }
    _topRoute = previousRoute;
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
    final previousName =
        previousRoute == null ? null : nameExtractor(previousRoute);
    if (previousName != null && previousName.isNotEmpty) {
      props['previous'] = previousName;
    }
    tracking.event(eventName, url: name, props: props);
  }
}
