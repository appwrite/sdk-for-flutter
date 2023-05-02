part of appwrite;

// regex to extract method name and params
final _methodAndParamsRegEx = RegExp(r'(\w+)\((.*)\)');

class Query {
  Query._(this.method, this.params);

  static equal(String attribute, dynamic value) =>
      _addQuery(attribute, 'equal', value);

  static notEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'notEqual', value);

  static lessThan(String attribute, dynamic value) =>
      _addQuery(attribute, 'lessThan', value);

  static lessThanEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'lessThanEqual', value);

  static greaterThan(String attribute, dynamic value) =>
      _addQuery(attribute, 'greaterThan', value);

  static greaterThanEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'greaterThanEqual', value);

  static search(String attribute, String value) =>
      _addQuery(attribute, 'search', value);

  static String orderAsc(String attribute) => 'orderAsc("$attribute")';

  static String orderDesc(String attribute) => 'orderDesc("$attribute")';

  static String cursorBefore(String id) => 'cursorBefore("$id")';

  static String cursorAfter(String id) => 'cursorAfter("$id")';

  static String limit(int limit) => 'limit($limit)';

  static String offset(int offset) => 'offset($offset)';

  static String _addQuery(String attribute, String method, dynamic value) => (value
          is List)
      ? '$method("$attribute", [${value.map((item) => parseValues(item)).join(",")}])'
      : '$method("$attribute", [${parseValues(value)}])';

  static String parseValues(dynamic value) =>
      (value is String) ? '"$value"' : '$value';

  final String method;
  final List<dynamic> params;

  factory Query.parse(String query) {
    if (!query.contains('(') || !query.contains(')')) {
      throw Exception('Invalid query');
    }

    final matches = _methodAndParamsRegEx.firstMatch(query);

    if (matches == null || matches.groupCount < 2) {
      throw Exception('Invalid query');
    }

    final method = matches.group(1)!;

    try {
      final params = jsonDecode('[' + matches.group(2)! + ']') as List<dynamic>;

      return Query._(method, params);
    } catch (e) {
      throw Exception('Invalid query');
    }
  }
}
