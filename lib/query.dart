part of appwrite;

/// Helper class to generate query strings.
class Query {
  Query._();

  /// Filter resources where [attribute] is equal to [value].
  /// 
  /// [value] can be a single value or a list. If a list is used
  /// the query will return resources where [attribute] is equal
  /// to any of the values in the list.
  static String equal(String attribute, dynamic value) =>
      _addQuery(attribute, 'equal', value);

  /// Filter resources where [attribute] is not equal to [value].
  static String notEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'notEqual', value);

  /// Filter resources where [attribute] is less than [value].
  static String lessThan(String attribute, dynamic value) =>
      _addQuery(attribute, 'lessThan', value);

  /// Filter resources where [attribute] is less than or equal to [value].
  static String lessThanEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'lessThanEqual', value);

  /// Filter resources where [attribute] is greater than [value].
  static String greaterThan(String attribute, dynamic value) =>
      _addQuery(attribute, 'greaterThan', value);

  /// Filter resources where [attribute] is greater than or equal to [value].
  static String greaterThanEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'greaterThanEqual', value);

  /// Filter resources where by searching [attribute] for [value].
  /// 
  /// A fulltext index on [attribute] is required for this query to work.
  static String search(String attribute, String value) =>
      _addQuery(attribute, 'search', value);

  /// Filter resources where [attribute] is null.
  static String isNull(String attribute) => 'isNull("$attribute")';

  /// Filter resources where [attribute] is not null.
  static String isNotNull(String attribute) => 'isNotNull("$attribute")';

  /// Filter resources where [attribute] is between [start] and [end] (inclusive).
  static String between(String attribute, dynamic start, dynamic end) =>
      _addQuery(attribute, 'between', [start, end]);

  /// Filter resources where [attribute] starts with [value].
  static String startsWith(String attribute, String value) =>
      _addQuery(attribute, 'startsWith', value);

  /// Filter resources where [attribute] ends with [value].
  static String endsWith(String attribute, String value) =>
      _addQuery(attribute, 'endsWith', value);

  /// Specify which attributes should be returned by the API call.
  static String select(List<String> attributes) =>
      'select([${attributes.map((attr) => "\"$attr\"").join(",")}])';

  /// Sort results by [attribute] ascending.
  static String orderAsc(String attribute) => 'orderAsc("$attribute")';

  /// Sort results by [attribute] descending.
  static String orderDesc(String attribute) => 'orderDesc("$attribute")';

  /// Return results before [id].
  /// 
  /// Refer to the [Cursor Based Pagination](https://appwrite.io/docs/pagination#cursor-pagination)
  /// docs for more information.
  static String cursorBefore(String id) => 'cursorBefore("$id")';

  /// Return results after [id].
  /// 
  /// Refer to the [Cursor Based Pagination](https://appwrite.io/docs/pagination#cursor-pagination)
  /// docs for more information.
  static String cursorAfter(String id) => 'cursorAfter("$id")';

  /// Return only [limit] results.
  static String limit(int limit) => 'limit($limit)';

  /// Return results from [offset].
  /// 
  /// Refer to the [Offset Pagination](https://appwrite.io/docs/pagination#offset-pagination)
  /// docs for more information.
  static String offset(int offset) => 'offset($offset)';

  static String _addQuery(String attribute, String method, dynamic value) => (value
          is List)
      ? '$method("$attribute", [${value.map((item) => _parseValues(item)).join(",")}])'
      : '$method("$attribute", [${_parseValues(value)}])';

  static String _parseValues(dynamic value) =>
      (value is String) ? '"$value"' : '$value';
}