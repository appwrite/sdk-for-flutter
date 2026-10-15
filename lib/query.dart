part of 'appwrite.dart';

/// Helper class to generate query strings.
class Query {
  final String method;
  final String? attribute;
  final dynamic values;

  Query._(this.method, [this.attribute, this.values]);

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

  /// Filter resources where [attribute] matches a regular expression pattern.
  ///
  /// [attribute] The attribute to filter on.
  /// [pattern] The regular expression pattern to match.
  static String regex(String attribute, String pattern) =>
      Query._('regex', attribute, pattern).toString();

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

  /// Filter resources where the specified attributes exist.
  ///
  /// [attributes] The list of attributes that must exist.
  static String exists(List<String> attributes) =>
      Query._('exists', null, attributes).toString();

  /// Filter resources where the specified attributes do not exist.
  ///
  /// [attributes] The list of attributes that must not exist.
  static String notExists(List<String> attributes) =>
      Query._('notExists', null, attributes).toString();

  /// Filter resources where [attribute] is between [start] and [end] (inclusive).
  static String between(String attribute, dynamic start, dynamic end) =>
      Query._('between', attribute, [start, end]).toString();

  /// Filter resources where [attribute] starts with [value].
  static String startsWith(String attribute, String value) =>
      Query._('startsWith', attribute, value).toString();

  /// Filter resources where [attribute] ends with [value].
  static String endsWith(String attribute, String value) =>
      Query._('endsWith', attribute, value).toString();

  /// Filter resources where [attribute] contains [value].
  /// For string attributes, checks if the string contains the substring.
  /// [value] can be a single value or a list.
  ///
  /// Note: For array attributes, use [containsAny] or [containsAll] instead.
  static String contains(String attribute, dynamic value) =>
      Query._('contains', attribute, value).toString();

  /// Filter resources where [attribute] contains ANY of the specified [value]s.
  /// For array and relationship attributes, matches documents where the attribute
  /// contains at least one of the given values.
  static String containsAny(String attribute, List<dynamic> value) =>
      Query._('containsAny', attribute, value).toString();

  /// Filter resources where [attribute] contains ALL of the specified [value]s.
  /// For array and relationship attributes, matches documents where the attribute
  /// contains every one of the given values.
  static String containsAll(String attribute, List<dynamic> value) =>
      Query._('containsAll', attribute, value).toString();

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
  static String createdBefore(String value) => lessThan('\$createdAt', value);

  /// Filter resources where document was created after [value].
  static String createdAfter(String value) => greaterThan('\$createdAt', value);

  /// Filter resources where document was created between [start] and [end] (inclusive).
  static String createdBetween(String start, String end) =>
      between('\$createdAt', start, end);

  /// Filter resources where document was updated before [value].
  static String updatedBefore(String value) => lessThan('\$updatedAt', value);

  /// Filter resources where document was updated after [value].
  static String updatedAfter(String value) => greaterThan('\$updatedAt', value);

  /// Filter resources where document was updated between [start] and [end] (inclusive).
  static String updatedBetween(String start, String end) =>
      between('\$updatedAt', start, end);

  static String or(List<String> queries) {
    return Query._(
      'or',
      null,
      queries.map((query) => jsonDecode(query)).toList(),
    ).toString();
  }

  static String and(List<String> queries) {
    return Query._(
      'and',
      null,
      queries.map((query) => jsonDecode(query)).toList(),
    ).toString();
  }

  /// Filter array elements where at least one element matches all the specified queries.
  ///
  /// [attribute] The attribute containing the array to filter on.
  /// [queries] The list of query strings to match against array elements.
  static String elemMatch(String attribute, List<String> queries) {
    return Query._(
      'elemMatch',
      attribute,
      queries.map((query) => jsonDecode(query)).toList(),
    ).toString();
  }

  /// Constrain populated related documents on a relationship attribute.
  ///
  /// [attribute] The relationship attribute to query.
  /// [queries] Filter, order, select, and pagination queries applied to related documents.
  static String relationship(String attribute, List<String> queries) => Query._(
        'relationship',
        attribute,
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
  ]) {
    return Query._('distanceEqual', attribute, [
      [values, distance, meters],
    ]).toString();
  }

  /// Filter resources where [attribute] is not at a specific distance from the given coordinates.
  static String distanceNotEqual(
    String attribute,
    List<dynamic> values,
    num distance, [
    bool meters = true,
  ]) {
    return Query._('distanceNotEqual', attribute, [
      [values, distance, meters],
    ]).toString();
  }

  /// Filter resources where [attribute] is at a distance greater than the specified value from the given coordinates.
  static String distanceGreaterThan(
    String attribute,
    List<dynamic> values,
    num distance, [
    bool meters = true,
  ]) {
    return Query._('distanceGreaterThan', attribute, [
      [values, distance, meters],
    ]).toString();
  }

  /// Filter resources where [attribute] is at a distance less than the specified value from the given coordinates.
  static String distanceLessThan(
    String attribute,
    List<dynamic> values,
    num distance, [
    bool meters = true,
  ]) {
    return Query._('distanceLessThan', attribute, [
      [values, distance, meters],
    ]).toString();
  }

  /// Filter resources using vector dot product similarity.
  static String vectorDot(String attribute, List<num> vector) =>
      Query._('vectorDot', attribute, [vector]).toString();

  /// Filter resources using vector cosine similarity.
  static String vectorCosine(String attribute, List<num> vector) =>
      Query._('vectorCosine', attribute, [vector]).toString();

  /// Filter resources using vector Euclidean distance.
  static String vectorEuclidean(String attribute, List<num> vector) =>
      Query._('vectorEuclidean', attribute, [vector]).toString();

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

  /// Count documents, optionally aliased.
  static String count([String attribute = '*', String alias = '']) =>
      Query._('count', attribute, alias.isNotEmpty ? alias : null).toString();

  /// Count distinct values of [attribute], optionally aliased.
  static String countDistinct(String attribute, [String alias = '']) =>
      Query._('countDistinct', attribute, alias.isNotEmpty ? alias : null)
          .toString();

  /// Sum values of [attribute], optionally aliased.
  static String sum(String attribute, [String alias = '']) =>
      Query._('sum', attribute, alias.isNotEmpty ? alias : null).toString();

  /// Average values of [attribute], optionally aliased.
  static String avg(String attribute, [String alias = '']) =>
      Query._('avg', attribute, alias.isNotEmpty ? alias : null).toString();

  /// Minimum value of [attribute], optionally aliased.
  static String min(String attribute, [String alias = '']) =>
      Query._('min', attribute, alias.isNotEmpty ? alias : null).toString();

  /// Maximum value of [attribute], optionally aliased.
  static String max(String attribute, [String alias = '']) =>
      Query._('max', attribute, alias.isNotEmpty ? alias : null).toString();

  /// Standard deviation of [attribute], optionally aliased.
  static String stddev(String attribute, [String alias = '']) =>
      Query._('stddev', attribute, alias.isNotEmpty ? alias : null).toString();

  /// Population standard deviation of [attribute], optionally aliased.
  static String stddevPop(String attribute, [String alias = '']) =>
      Query._('stddevPop', attribute, alias.isNotEmpty ? alias : null)
          .toString();

  /// Sample standard deviation of [attribute], optionally aliased.
  static String stddevSamp(String attribute, [String alias = '']) =>
      Query._('stddevSamp', attribute, alias.isNotEmpty ? alias : null)
          .toString();

  /// Variance of [attribute], optionally aliased.
  static String variance(String attribute, [String alias = '']) =>
      Query._('variance', attribute, alias.isNotEmpty ? alias : null)
          .toString();

  /// Population variance of [attribute], optionally aliased.
  static String varPop(String attribute, [String alias = '']) =>
      Query._('varPop', attribute, alias.isNotEmpty ? alias : null).toString();

  /// Sample variance of [attribute], optionally aliased.
  static String varSamp(String attribute, [String alias = '']) =>
      Query._('varSamp', attribute, alias.isNotEmpty ? alias : null).toString();

  /// Bitwise AND of [attribute], optionally aliased.
  static String bitAnd(String attribute, [String alias = '']) =>
      Query._('bitAnd', attribute, alias.isNotEmpty ? alias : null).toString();

  /// Bitwise OR of [attribute], optionally aliased.
  static String bitOr(String attribute, [String alias = '']) =>
      Query._('bitOr', attribute, alias.isNotEmpty ? alias : null).toString();

  /// Bitwise XOR of [attribute], optionally aliased.
  static String bitXor(String attribute, [String alias = '']) =>
      Query._('bitXor', attribute, alias.isNotEmpty ? alias : null).toString();

  /// Group results by [attributes].
  static String groupBy(List<String> attributes) =>
      Query._('groupBy', null, attributes).toString();

  /// Filter grouped results. [queries] are nested like [and]/[or].
  static String having(List<String> queries) => Query._(
        'having',
        null,
        queries.map((query) => jsonDecode(query)).toList(),
      ).toString();

  /// Select distinct rows.
  static String distinct() => Query._('distinct').toString();

  /// Column-to-column join ON condition.
  static String on(String left, String right, [String operator = '=']) =>
      Query._('on', null, [left, operator, right]).toString();

  /// Inner join. [table] is the joined collection/table ID.
  static String join(
    String table,
    Object leftOrAliasOrOn, [
    Object rightOrOn = '',
    String operator = '=',
    String alias = '',
  ]) =>
      Query._createJoin('join', table, leftOrAliasOrOn, rightOrOn, operator, alias);

  /// Left join. [table] is the joined collection/table ID.
  static String leftJoin(
    String table,
    Object leftOrAliasOrOn, [
    Object rightOrOn = '',
    String operator = '=',
    String alias = '',
  ]) =>
      Query._createJoin('leftJoin', table, leftOrAliasOrOn, rightOrOn, operator, alias);

  /// Right join. [table] is the joined collection/table ID.
  static String rightJoin(
    String table,
    Object leftOrAliasOrOn, [
    Object rightOrOn = '',
    String operator = '=',
    String alias = '',
  ]) =>
      Query._createJoin('rightJoin', table, leftOrAliasOrOn, rightOrOn, operator, alias);

  /// Full outer join. [table] is the joined collection/table ID.
  static String fullOuterJoin(
    String table,
    Object leftOrAliasOrOn, [
    Object rightOrOn = '',
    String operator = '=',
    String alias = '',
  ]) =>
      Query._createJoin('fullOuterJoin', table, leftOrAliasOrOn, rightOrOn, operator, alias);

  /// Cross join. [table] is the joined collection/table ID.
  static String crossJoin(String table, [String alias = '']) =>
      Query._('crossJoin', table, alias.isNotEmpty ? alias : null).toString();

  /// Filter resources where [attribute] covers the given geometry.
  static String covers(String attribute, List<dynamic> values) =>
      Query._('covers', attribute, [values]).toString();

  /// Filter resources where [attribute] does not cover the given geometry.
  static String notCovers(String attribute, List<dynamic> values) =>
      Query._('notCovers', attribute, [values]).toString();

  /// Filter resources where [attribute] is spatially equal to the given geometry.
  static String spatialEquals(String attribute, List<dynamic> values) =>
      Query._('spatialEquals', attribute, [values]).toString();

  /// Filter resources where [attribute] is not spatially equal to the given geometry.
  static String notSpatialEquals(String attribute, List<dynamic> values) =>
      Query._('notSpatialEquals', attribute, [values]).toString();

  /// Return limit and offset queries for 1-based page pagination.
  static List<String> page(int page, [int perPage = 25]) {
    if (page < 1) {
      throw ArgumentError('Page must be >= 1, got $page');
    }
    if (perPage < 1) {
      throw ArgumentError('Per page must be >= 1, got $perPage');
    }

    return [
      Query.limit(perPage),
      Query.offset((page - 1) * perPage),
    ];
  }

  /// Start a fluent query builder.
  static QueryBuilder builder() => QueryBuilder();

  static String _createJoin(
    String method,
    String table,
    Object leftOrAliasOrOn,
    Object rightOrOn,
    String operator,
    String alias,
  ) {
    if (leftOrAliasOrOn is List) {
      return Query._nestedJoin(method, table, '', leftOrAliasOrOn);
    }
    if (rightOrOn is List) {
      return Query._nestedJoin(method, table, leftOrAliasOrOn.toString(), rightOrOn);
    }

    return Query._joinQuery(
      method,
      table,
      leftOrAliasOrOn.toString(),
      rightOrOn.toString(),
      operator,
      alias,
    );
  }

  static String _nestedJoin(
    String method,
    String table,
    String alias,
    List<dynamic> on,
  ) {
    final values = <dynamic>[];
    if (alias.isNotEmpty) {
      values.add(alias);
    }
    for (final query in on) {
      values.add(jsonDecode(query.toString()));
    }

    return Query._(method, table, values).toString();
  }

  static String _joinQuery(
    String method,
    String table,
    String left,
    String right,
    String operator,
    String alias,
  ) {
    final values = <String>[left, operator, right];
    if (alias.isNotEmpty) {
      values.add(alias);
    }

    return Query._(method, table, values).toString();
  }
}
