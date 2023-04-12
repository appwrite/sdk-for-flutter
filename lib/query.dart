part of appwrite;

class Query {
    Query._();
    
  static String equal(String attribute, dynamic value) =>
      _addQuery(attribute, 'equal', value);

  static String notEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'notEqual', value);

  static String lessThan(String attribute, dynamic value) =>
      _addQuery(attribute, 'lessThan', value);

  static String lessThanEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'lessThanEqual', value);

  static String greaterThan(String attribute, dynamic value) =>
      _addQuery(attribute, 'greaterThan', value);

  static String greaterThanEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'greaterThanEqual', value);

  static String search(String attribute, String value) =>
      _addQuery(attribute, 'search', value);

  static String isNull(String attribute) => 'isNull("$attribute")';

  static String isNotNull(String attribute) => 'isNotNull("$attribute")';

  static String between(String attribute, dynamic start, dynamic end) =>
      _addQuery(attribute, 'between', [start, end]);

  static String startsWith(String attribute, String value) =>
      _addQuery(attribute, 'startsWith', value);

  static String endsWith(String attribute, String value) =>
      _addQuery(attribute, 'endsWith', value);

  static String select(List<String> attributes) => 'select([${attributes.map((attr) => "\"$attr\"").join(",")}])';

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
}
