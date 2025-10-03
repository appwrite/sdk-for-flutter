part of 'appwrite.dart';

/// Helper class to generate query strings.
class Query {
  final String method;
  final String? attribute;
  final dynamic values;

  Query._(this.method, [this.attribute = null, this.values = null]);

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result['method'] = method;

    if (attribute != null) {
      result['attribute'] = attribute;
    }

    if (values != null) {
      result['values'] = values is List ? values : [values];
    }

    return result;
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
      Query._('notEqual', attribute, value).toString();

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

  /// Filter resources where [attribute] does not contain [value]
  /// [value] can be a single value or a list.
  static String notContains(String attribute, dynamic value) =>
      Query._('notContains', attribute, value).toString();

  /// Filter resources by searching [attribute] for [value] (inverse of search).
  static String notSearch(String attribute, String value) =>
      Query._('notSearch', attribute, value).toString();

  /// Filter resources where [attribute] is not between [start] and [end] (exclusive).
  static String notBetween(String attribute, dynamic start, dynamic end) =>
      Query._('notBetween', attribute, [start, end]).toString();

  /// Filter resources where [attribute] does not start with [value].
  static String notStartsWith(String attribute, String value) =>
      Query._('notStartsWith', attribute, value).toString();

  /// Filter resources where [attribute] does not end with [value].
  static String notEndsWith(String attribute, String value) =>
      Query._('notEndsWith', attribute, value).toString();

  /// Filter resources where document was created before [value].
  static String createdBefore(String value) =>
      Query._('createdBefore', null, value).toString();

  /// Filter resources where document was created after [value].
  static String createdAfter(String value) =>
      Query._('createdAfter', null, value).toString();

  /// Filter resources where document was created between [start] and [end] (inclusive).
  static String createdBetween(String start, String end) =>
      Query._('createdBetween', null, [start, end]).toString();

  /// Filter resources where document was updated before [value].
  static String updatedBefore(String value) =>
      Query._('updatedBefore', null, value).toString();

  /// Filter resources where document was updated after [value].
  static String updatedAfter(String value) =>
      Query._('updatedAfter', null, value).toString();

  /// Filter resources where document was updated between [start] and [end] (inclusive).
  static String updatedBetween(String start, String end) =>
      Query._('updatedBetween', null, [start, end]).toString();

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

  /// Sort results randomly.
  static String orderRandom() => Query._('orderRandom').toString();

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

  /// Filter resources where [attribute] is at a specific distance from the given coordinates.
  static String distanceEqual(
    String attribute,
    List<dynamic> values,
    num distance, [
    bool meters = true,
  ]) => Query._('distanceEqual', attribute, [
    [values, distance, meters],
  ]).toString();

  /// Filter resources where [attribute] is not at a specific distance from the given coordinates.
  static String distanceNotEqual(
    String attribute,
    List<dynamic> values,
    num distance, [
    bool meters = true,
  ]) => Query._('distanceNotEqual', attribute, [
    [values, distance, meters],
  ]).toString();

  /// Filter resources where [attribute] is at a distance greater than the specified value from the given coordinates.
  static String distanceGreaterThan(
    String attribute,
    List<dynamic> values,
    num distance, [
    bool meters = true,
  ]) => Query._('distanceGreaterThan', attribute, [
    [values, distance, meters],
  ]).toString();

  /// Filter resources where [attribute] is at a distance less than the specified value from the given coordinates.
  static String distanceLessThan(
    String attribute,
    List<dynamic> values,
    num distance, [
    bool meters = true,
  ]) => Query._('distanceLessThan', attribute, [
    [values, distance, meters],
  ]).toString();

  /// Filter resources where [attribute] intersects with the given geometry.
  static String intersects(String attribute, List<dynamic> values) =>
      Query._('intersects', attribute, [values]).toString();

  /// Filter resources where [attribute] does not intersect with the given geometry.
  static String notIntersects(String attribute, List<dynamic> values) =>
      Query._('notIntersects', attribute, [values]).toString();

  /// Filter resources where [attribute] crosses the given geometry.
  static String crosses(String attribute, List<dynamic> values) =>
      Query._('crosses', attribute, [values]).toString();

  /// Filter resources where [attribute] does not cross the given geometry.
  static String notCrosses(String attribute, List<dynamic> values) =>
      Query._('notCrosses', attribute, [values]).toString();

  /// Filter resources where [attribute] overlaps with the given geometry.
  static String overlaps(String attribute, List<dynamic> values) =>
      Query._('overlaps', attribute, [values]).toString();

  /// Filter resources where [attribute] does not overlap with the given geometry.
  static String notOverlaps(String attribute, List<dynamic> values) =>
      Query._('notOverlaps', attribute, [values]).toString();

  /// Filter resources where [attribute] touches the given geometry.
  static String touches(String attribute, List<dynamic> values) =>
      Query._('touches', attribute, [values]).toString();

  /// Filter resources where [attribute] does not touch the given geometry.
  static String notTouches(String attribute, List<dynamic> values) =>
      Query._('notTouches', attribute, [values]).toString();
}
