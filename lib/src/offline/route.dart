class Route {
  String method = '';
  String path;
  final List<String> _aliases = [];
  final Map<String, dynamic> labels = {};

  final Map<String, int> _pathParams = {};

  Route(this.method, this.path) : super();

  List<String> get aliases => _aliases;
  Map<String, int> get pathParams => _pathParams;

  Route alias(String path) {
    if (!_aliases.contains(path)) {
      _aliases.add(path);
    }

    return this;
  }

  void setPathParam(String key, int index) {
    _pathParams[key] = index;
  }

  Map<String, String> getPathValues(String path) {
    var pathValues = <String, String>{};
    var parts = path.split('/').where((part) => part.isNotEmpty);

    for (var entry in pathParams.entries) {
      if (entry.value < parts.length) {
        pathValues[entry.key] = parts.elementAt(entry.value);
      }
    }

    return pathValues;
  }

  Route label(String key, String value) {
    labels[key] = value;
    return this;
  }

  String? getLabel(String key, {String? defaultValue}) {
    return labels[key] ?? defaultValue;
  }
}
