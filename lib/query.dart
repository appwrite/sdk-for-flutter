part of 'appwrite.dart';

/// Helper class to generate query strings.
class Query {
  final String method;
  final String? attribute;
  final dynamic values;

  Query._(this.method, [this.attribute = null, this.values = null]);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'method': method};

    if (attribute != null) {
      map['attribute'] = attribute;
    }

    if (values != null) {
      map['values'] = values is List ? values : [values];
    }

    return map;
  }

  @override
  String toString() => jsonEncode(toJson());

  /// Filter resources where [attribute] is equal to [value].
  ///
  /// [value] can be a single value or a list. If a list is used
  /// the query will return resources where [attribute] is equal
  /// to any of the values in the list.
  static String equal(String attribute, dynamic value) =>
      Query._('equal', attribute, value).toString();

  /// Filter resources where [attribute] is not equal to [value].
  static String notEqual(String attribute, dynamic value) =>
      Query._('notEqual', attribute, [value]).toString();

  /// Filter resources where [attribute] is less than [value].
  static String lessThan(String attribute, dynamic value) =>
      Query._('lessThan', attribute, value).toString();

  /// Filter resources where [attribute] is less than or equal to [value].
  static String lessThanEqual(String attribute, dynamic value) =>
      Query._('lessThanEqual', attribute, value).toString();

  /// Filter resources where [attribute] is greater than [value].
  static String greaterThan(String attribute, dynamic value) =>
      Query._('greaterThan', attribute, value).toString();

  /// Filter resources where [attribute] is greater than or equal to [value].
  static String greaterThanEqual(String attribute, dynamic value) =>
      Query._('greaterThanEqual', attribute, value).toString();

  /// Filter resources where by searching [attribute] for [value].
  static String search(String attribute, String value) =>
      Query._('search', attribute, value).toString();

  /// Filter resources where [attribute] is null.
  static String isNull(String attribute) =>
      Query._('isNull', attribute).toString();

  /// Filter resources where [attribute] is not null.
  static String isNotNull(String attribute) =>
      Query._('isNotNull', attribute).toString();

  /// Filter resources where [attribute] is between [start] and [end] (inclusive).
  static String between(String attribute, dynamic start, dynamic end) =>
      Query._('between', attribute, [start, end]).toString();

  /// Filter resources where [attribute] starts with [value].
  static String startsWith(String attribute, String value) =>
      Query._('startsWith', attribute, value).toString();

  /// Filter resources where [attribute] ends with [value].
  static String endsWith(String attribute, String value) =>
      Query._('endsWith', attribute, value).toString();

  /// Filter resources where [attribute] contains [value]
  /// [value] can be a single value or a list.
  static String contains(String attribute, dynamic value) =>
      Query._('contains', attribute, value).toString();

  static String or(List<String> queries) => Query._(
    'or',
    null,
    queries.map((query) => jsonDecode(query)).toList(),
  ).toString();

  static String and(List<String> queries) => Query._(
    'and',
    null,
    queries.map((query) => jsonDecode(query)).toList(),
  ).toString();

  /// Specify which attributes should be returned by the API call.
  static String select(List<String> attributes) =>
      Query._('select', null, attributes).toString();

  /// Sort results by [attribute] ascending.
  static String orderAsc(String attribute) =>
      Query._('orderAsc', attribute).toString();

  /// Sort results by [attribute] descending.
  static String orderDesc(String attribute) =>
      Query._('orderDesc', attribute).toString();

  /// Return results before [id].
  ///
  /// Refer to the [Cursor Based Pagination](https://appwrite.io/docs/pagination#cursor-pagination)
  /// docs for more information.
  static String cursorBefore(String id) =>
      Query._('cursorBefore', null, id).toString();

  /// Return results after [id].
  ///
  /// Refer to the [Cursor Based Pagination](https://appwrite.io/docs/pagination#cursor-pagination)
  /// docs for more information.
  static String cursorAfter(String id) =>
      Query._('cursorAfter', null, id).toString();

  /// Return only [limit] results.
  static String limit(int limit) => Query._('limit', null, limit).toString();

  /// Return results from [offset].
  ///
  /// Refer to the [Offset Pagination](https://appwrite.io/docs/pagination#offset-pagination)
  /// docs for more information.
  static String offset(int offset) =>
      Query._('offset', null, offset).toString();
}
