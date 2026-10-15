part of '../appwrite.dart';

/// Fluent collector of query strings. Call [build] to produce the list
/// expected by list methods.
class QueryBuilder {
  final List<String> _queries = [];

  List<String> build() => List<String>.from(_queries);

  QueryBuilder equal(String attribute, dynamic value) =>
      _push(Query.equal(attribute, value));

  QueryBuilder notEqual(String attribute, dynamic value) =>
      _push(Query.notEqual(attribute, value));

  QueryBuilder lessThan(String attribute, dynamic value) =>
      _push(Query.lessThan(attribute, value));

  QueryBuilder lessThanEqual(String attribute, dynamic value) =>
      _push(Query.lessThanEqual(attribute, value));

  QueryBuilder greaterThan(String attribute, dynamic value) =>
      _push(Query.greaterThan(attribute, value));

  QueryBuilder greaterThanEqual(String attribute, dynamic value) =>
      _push(Query.greaterThanEqual(attribute, value));

  QueryBuilder search(String attribute, String value) =>
      _push(Query.search(attribute, value));

  QueryBuilder isNull(String attribute) => _push(Query.isNull(attribute));

  QueryBuilder isNotNull(String attribute) =>
      _push(Query.isNotNull(attribute));

  QueryBuilder between(String attribute, dynamic start, dynamic end) =>
      _push(Query.between(attribute, start, end));

  QueryBuilder startsWith(String attribute, String value) =>
      _push(Query.startsWith(attribute, value));

  QueryBuilder endsWith(String attribute, String value) =>
      _push(Query.endsWith(attribute, value));

  QueryBuilder select(List<String> attributes) =>
      _push(Query.select(attributes));

  QueryBuilder cursorAfter(String documentId) =>
      _push(Query.cursorAfter(documentId));

  QueryBuilder cursorBefore(String documentId) =>
      _push(Query.cursorBefore(documentId));

  QueryBuilder orderAsc(String attribute) =>
      _push(Query.orderAsc(attribute));

  QueryBuilder orderDesc(String attribute) =>
      _push(Query.orderDesc(attribute));

  QueryBuilder orderRandom() => _push(Query.orderRandom());

  QueryBuilder limit(int limit) => _push(Query.limit(limit));

  QueryBuilder offset(int offset) => _push(Query.offset(offset));

  QueryBuilder contains(String attribute, dynamic value) =>
      _push(Query.contains(attribute, value));

  QueryBuilder containsAny(String attribute, List<dynamic> value) =>
      _push(Query.containsAny(attribute, value));

  QueryBuilder containsAll(String attribute, List<dynamic> value) =>
      _push(Query.containsAll(attribute, value));

  QueryBuilder notContains(String attribute, dynamic value) =>
      _push(Query.notContains(attribute, value));

  QueryBuilder notSearch(String attribute, String value) =>
      _push(Query.notSearch(attribute, value));

  QueryBuilder notBetween(String attribute, dynamic start, dynamic end) =>
      _push(Query.notBetween(attribute, start, end));

  QueryBuilder notStartsWith(String attribute, String value) =>
      _push(Query.notStartsWith(attribute, value));

  QueryBuilder notEndsWith(String attribute, String value) =>
      _push(Query.notEndsWith(attribute, value));

  QueryBuilder regex(String attribute, String pattern) =>
      _push(Query.regex(attribute, pattern));

  QueryBuilder exists(List<String> attributes) =>
      _push(Query.exists(attributes));

  QueryBuilder notExists(List<String> attributes) =>
      _push(Query.notExists(attributes));

  QueryBuilder createdBefore(String value) =>
      _push(Query.createdBefore(value));

  QueryBuilder createdAfter(String value) =>
      _push(Query.createdAfter(value));

  QueryBuilder createdBetween(String start, String end) =>
      _push(Query.createdBetween(start, end));

  QueryBuilder updatedBefore(String value) =>
      _push(Query.updatedBefore(value));

  QueryBuilder updatedAfter(String value) =>
      _push(Query.updatedAfter(value));

  QueryBuilder updatedBetween(String start, String end) =>
      _push(Query.updatedBetween(start, end));

  QueryBuilder or(List<String> queries) => _push(Query.or(queries));

  QueryBuilder and(List<String> queries) => _push(Query.and(queries));

  QueryBuilder elemMatch(String attribute, List<String> queries) =>
      _push(Query.elemMatch(attribute, queries));

  QueryBuilder relationship(String attribute, List<String> queries) =>
      _push(Query.relationship(attribute, queries));

  QueryBuilder distanceEqual(
    String attribute,
    List<dynamic> values,
    num distance, [
    bool meters = true,
  ]) =>
      _push(Query.distanceEqual(attribute, values, distance, meters));

  QueryBuilder distanceNotEqual(
    String attribute,
    List<dynamic> values,
    num distance, [
    bool meters = true,
  ]) =>
      _push(Query.distanceNotEqual(attribute, values, distance, meters));

  QueryBuilder distanceGreaterThan(
    String attribute,
    List<dynamic> values,
    num distance, [
    bool meters = true,
  ]) =>
      _push(Query.distanceGreaterThan(attribute, values, distance, meters));

  QueryBuilder distanceLessThan(
    String attribute,
    List<dynamic> values,
    num distance, [
    bool meters = true,
  ]) =>
      _push(Query.distanceLessThan(attribute, values, distance, meters));

  QueryBuilder intersects(String attribute, List<dynamic> values) =>
      _push(Query.intersects(attribute, values));

  QueryBuilder notIntersects(String attribute, List<dynamic> values) =>
      _push(Query.notIntersects(attribute, values));

  QueryBuilder crosses(String attribute, List<dynamic> values) =>
      _push(Query.crosses(attribute, values));

  QueryBuilder notCrosses(String attribute, List<dynamic> values) =>
      _push(Query.notCrosses(attribute, values));

  QueryBuilder overlaps(String attribute, List<dynamic> values) =>
      _push(Query.overlaps(attribute, values));

  QueryBuilder notOverlaps(String attribute, List<dynamic> values) =>
      _push(Query.notOverlaps(attribute, values));

  QueryBuilder touches(String attribute, List<dynamic> values) =>
      _push(Query.touches(attribute, values));

  QueryBuilder notTouches(String attribute, List<dynamic> values) =>
      _push(Query.notTouches(attribute, values));

  QueryBuilder count([String attribute = '*', String alias = '']) =>
      _push(Query.count(attribute, alias));

  QueryBuilder countDistinct(String attribute, [String alias = '']) =>
      _push(Query.countDistinct(attribute, alias));

  QueryBuilder sum(String attribute, [String alias = '']) =>
      _push(Query.sum(attribute, alias));

  QueryBuilder avg(String attribute, [String alias = '']) =>
      _push(Query.avg(attribute, alias));

  QueryBuilder min(String attribute, [String alias = '']) =>
      _push(Query.min(attribute, alias));

  QueryBuilder max(String attribute, [String alias = '']) =>
      _push(Query.max(attribute, alias));

  QueryBuilder stddev(String attribute, [String alias = '']) =>
      _push(Query.stddev(attribute, alias));

  QueryBuilder stddevPop(String attribute, [String alias = '']) =>
      _push(Query.stddevPop(attribute, alias));

  QueryBuilder stddevSamp(String attribute, [String alias = '']) =>
      _push(Query.stddevSamp(attribute, alias));

  QueryBuilder variance(String attribute, [String alias = '']) =>
      _push(Query.variance(attribute, alias));

  QueryBuilder varPop(String attribute, [String alias = '']) =>
      _push(Query.varPop(attribute, alias));

  QueryBuilder varSamp(String attribute, [String alias = '']) =>
      _push(Query.varSamp(attribute, alias));

  QueryBuilder bitAnd(String attribute, [String alias = '']) =>
      _push(Query.bitAnd(attribute, alias));

  QueryBuilder bitOr(String attribute, [String alias = '']) =>
      _push(Query.bitOr(attribute, alias));

  QueryBuilder bitXor(String attribute, [String alias = '']) =>
      _push(Query.bitXor(attribute, alias));

  QueryBuilder groupBy(List<String> attributes) =>
      _push(Query.groupBy(attributes));

  QueryBuilder having(List<String> queries) => _push(Query.having(queries));

  QueryBuilder distinct() => _push(Query.distinct());

  QueryBuilder join(
    String table,
    Object leftOrAliasOrOn, [
    Object rightOrOn = '',
    String operator = '=',
    String alias = '',
  ]) =>
      _push(Query.join(table, leftOrAliasOrOn, rightOrOn, operator, alias));

  QueryBuilder leftJoin(
    String table,
    Object leftOrAliasOrOn, [
    Object rightOrOn = '',
    String operator = '=',
    String alias = '',
  ]) =>
      _push(Query.leftJoin(table, leftOrAliasOrOn, rightOrOn, operator, alias));

  QueryBuilder rightJoin(
    String table,
    Object leftOrAliasOrOn, [
    Object rightOrOn = '',
    String operator = '=',
    String alias = '',
  ]) =>
      _push(Query.rightJoin(table, leftOrAliasOrOn, rightOrOn, operator, alias));

  QueryBuilder fullOuterJoin(
    String table,
    Object leftOrAliasOrOn, [
    Object rightOrOn = '',
    String operator = '=',
    String alias = '',
  ]) =>
      _push(Query.fullOuterJoin(table, leftOrAliasOrOn, rightOrOn, operator, alias));

  QueryBuilder crossJoin(String table, [String alias = '']) =>
      _push(Query.crossJoin(table, alias));

  QueryBuilder vectorDot(String attribute, List<num> vector) =>
      _push(Query.vectorDot(attribute, vector));

  QueryBuilder vectorCosine(String attribute, List<num> vector) =>
      _push(Query.vectorCosine(attribute, vector));

  QueryBuilder vectorEuclidean(String attribute, List<num> vector) =>
      _push(Query.vectorEuclidean(attribute, vector));

  QueryBuilder covers(String attribute, List<dynamic> values) =>
      _push(Query.covers(attribute, values));

  QueryBuilder notCovers(String attribute, List<dynamic> values) =>
      _push(Query.notCovers(attribute, values));

  QueryBuilder spatialEquals(String attribute, List<dynamic> values) =>
      _push(Query.spatialEquals(attribute, values));

  QueryBuilder notSpatialEquals(String attribute, List<dynamic> values) =>
      _push(Query.notSpatialEquals(attribute, values));

  QueryBuilder page(int page, [int perPage = 25]) =>
      _push(Query.page(page, perPage));

  QueryBuilder _push(Object query) {
    if (query is List) {
      _queries.addAll(query.cast<String>());
    } else {
      _queries.add(query as String);
    }
    return this;
  }
}
