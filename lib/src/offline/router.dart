import 'dart:collection';

import 'route.dart';

class Router {
  static const String placeholderToken = ':::';

  Map<String, Map<String, Route>> _routes = {
    'GET': {},
    'POST': {},
    'PUT': {},
    'PATCH': {},
    'DELETE': {},
  };

  List<int> _params = [];

  UnmodifiableMapView<String, Map<String, Route>> getRoutes() {
    return UnmodifiableMapView(_routes);
  }

  void addRoute(Route route) {
    List<dynamic> result = preparePath(route.path);
    String path = result[0];
    Map<String, int> params = result[1];

    if (!_routes.containsKey(route.method)) {
      throw Exception("Method (${route.method}) not supported.");
    }

    if (_routes[route.method]!.containsKey(path)) {
      throw Exception("Route for (${route.method}:$path) already registered.");
    }

    params.forEach((key, index) {
      route.setPathParam(key, index);
    });

    _routes[route.method]![path] = (route);

    for (String alias in route.aliases) {
      List<dynamic> aliasResult = preparePath(alias);
      String aliasPath = aliasResult[0];
      _routes[route.method]![aliasPath] = route;
    }
  }

  Route? match(String method, String path) {
    if (!_routes.containsKey(method)) {
      return null;
    }

    List<String> parts = path.split('/').where((p) => p.isNotEmpty).toList();
    int length = parts.length - 1;
    List<int> filteredParams = _params.where((i) => i <= length).toList();

    for (List<int> sample in combinations<int>(filteredParams)) {
      sample = sample.where((i) => i <= length).toList();
      String match = parts
          .asMap()
          .entries
          .map(
            (entry) =>
                sample.contains(entry.key) ? placeholderToken : entry.value,
          )
          .join('/');

      if (_routes[method]!.containsKey(match)) {
        return _routes[method]![match]!;
      }
    }

    return null;
  }

  Iterable<List<T>> combinations<T>(List<T> set) {
    final result = <List<T>>[[]];

    for (final element in set) {
      final newCombinations = <List<T>>[];
      for (final combination in result) {
        final ret = [element, ...combination];
        newCombinations.add(ret);
      }
      result.addAll(newCombinations);
    }

    return result;
  }

  List<dynamic> preparePath(String path) {
    List<String> parts = path.split('/').where((p) => p.isNotEmpty).toList();
    String prepare = '';
    Map<String, int> params = {};

    for (int key = 0; key < parts.length; key++) {
      String part = parts[key];
      if (key != 0) {
        prepare += '/';
      }

      if (part.startsWith('{') && part.endsWith('}')) {
        prepare += placeholderToken;
        params[part.substring(1, part.length - 1)] = key;
        if (!_params.contains(key)) {
          _params.add(key);
        }
      } else {
        prepare += part;
      }
    }

    return [prepare, params];
  }

  void reset() {
    _params = [];
    _routes = {
      'GET': {},
      'POST': {},
      'PUT': {},
      'PATCH': {},
      'DELETE': {},
    };
  }
}
