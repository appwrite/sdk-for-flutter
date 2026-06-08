part of 'appwrite.dart';

/// Filter condition for array operations
enum Condition {
  equal('equal'),
  notEqual('notEqual'),
  greaterThan('greaterThan'),
  greaterThanEqual('greaterThanEqual'),
  lessThan('lessThan'),
  lessThanEqual('lessThanEqual'),
  contains('contains'),
  isNull('isNull'),
  isNotNull('isNotNull');

  final String value;
  const Condition(this.value);

  @override
  String toString() => value;
}

/// Helper class to generate operator strings for atomic operations.
class Operator {
  final String method;
  final dynamic values;

  Operator._(this.method, [this.values = null]);

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result['method'] = method;

    if(values != null) {
      result['values'] = values is List ? values : [values];
    }

    return result;
  }

  @override
  String toString() => jsonEncode(toJson());

  /// Increment a numeric attribute by a specified value.
  static String increment([num value = 1, num? max]) {
    if (value.toDouble().isNaN || value.toDouble().isInfinite) {
      throw ArgumentError('Value cannot be NaN or Infinity');
    }
    if (max != null && (max.toDouble().isNaN || max.toDouble().isInfinite)) {
      throw ArgumentError('Max cannot be NaN or Infinity');
    }
    final values = <dynamic>[value];
    if (max != null) {
      values.add(max);
    }
    return Operator._('increment', values).toString();
  }

  /// Decrement a numeric attribute by a specified value.
  static String decrement([num value = 1, num? min]) {
    if (value.toDouble().isNaN || value.toDouble().isInfinite) {
      throw ArgumentError('Value cannot be NaN or Infinity');
    }
    if (min != null && (min.toDouble().isNaN || min.toDouble().isInfinite)) {
      throw ArgumentError('Min cannot be NaN or Infinity');
    }
    final values = <dynamic>[value];
    if (min != null) {
      values.add(min);
    }
    return Operator._('decrement', values).toString();
  }

  /// Multiply a numeric attribute by a specified factor.
  static String multiply(num factor, [num? max]) {
    if (factor.toDouble().isNaN || factor.toDouble().isInfinite) {
      throw ArgumentError('Factor cannot be NaN or Infinity');
    }
    if (max != null && (max.toDouble().isNaN || max.toDouble().isInfinite)) {
      throw ArgumentError('Max cannot be NaN or Infinity');
    }
    final values = <dynamic>[factor];
    if (max != null) {
      values.add(max);
    }
    return Operator._('multiply', values).toString();
  }

  /// Divide a numeric attribute by a specified divisor.
  static String divide(num divisor, [num? min]) {
    if (divisor.toDouble().isNaN || divisor.toDouble().isInfinite) {
      throw ArgumentError('Divisor cannot be NaN or Infinity');
    }
    if (min != null && (min.toDouble().isNaN || min.toDouble().isInfinite)) {
      throw ArgumentError('Min cannot be NaN or Infinity');
    }
    if (divisor == 0) {
      throw ArgumentError('Divisor cannot be zero');
    }
    final values = <dynamic>[divisor];
    if (min != null) {
      values.add(min);
    }
    return Operator._('divide', values).toString();
  }

  /// Apply modulo operation on a numeric attribute.
  static String modulo(num divisor) {
    if (divisor.toDouble().isNaN || divisor.toDouble().isInfinite) {
      throw ArgumentError('Divisor cannot be NaN or Infinity');
    }
    if (divisor == 0) {
      throw ArgumentError('Divisor cannot be zero');
    }
    return Operator._('modulo', [divisor]).toString();
  }

  /// Raise a numeric attribute to a specified power.
  static String power(num exponent, [num? max]) {
    if (exponent.toDouble().isNaN || exponent.toDouble().isInfinite) {
      throw ArgumentError('Exponent cannot be NaN or Infinity');
    }
    if (max != null && (max.toDouble().isNaN || max.toDouble().isInfinite)) {
      throw ArgumentError('Max cannot be NaN or Infinity');
    }
    final values = <dynamic>[exponent];
    if (max != null) {
      values.add(max);
    }
    return Operator._('power', values).toString();
  }

  /// Append values to an array attribute.
  static String arrayAppend(List<dynamic> values) =>
      Operator._('arrayAppend', values).toString();

  /// Prepend values to an array attribute.
  static String arrayPrepend(List<dynamic> values) =>
      Operator._('arrayPrepend', values).toString();

  /// Insert a value at a specific index in an array attribute.
  static String arrayInsert(int index, dynamic value) =>
      Operator._('arrayInsert', [index, value]).toString();

  /// Remove a value from an array attribute.
  static String arrayRemove(dynamic value) =>
      Operator._('arrayRemove', [value]).toString();

  /// Remove duplicate values from an array attribute.
  static String arrayUnique() =>
      Operator._('arrayUnique', []).toString();

  /// Keep only values that exist in both the current array and the provided array.
  static String arrayIntersect(List<dynamic> values) =>
      Operator._('arrayIntersect', values).toString();

  /// Remove values from the array that exist in the provided array.
  static String arrayDiff(List<dynamic> values) =>
      Operator._('arrayDiff', values).toString();

  /// Filter array values based on a condition.
  static String arrayFilter(Condition condition, [dynamic value]) {
    final values = <dynamic>[condition.value, value];
    return Operator._('arrayFilter', values).toString();
  }

  /// Concatenate a value to a string or array attribute.
  static String stringConcat(dynamic value) =>
      Operator._('stringConcat', [value]).toString();

  /// Replace occurrences of a search string with a replacement string.
  static String stringReplace(String search, String replace) =>
      Operator._('stringReplace', [search, replace]).toString();

  /// Toggle a boolean attribute.
  static String toggle() =>
      Operator._('toggle', []).toString();

  /// Add days to a date attribute.
  static String dateAddDays(int days) =>
      Operator._('dateAddDays', [days]).toString();

  /// Subtract days from a date attribute.
  static String dateSubDays(int days) =>
      Operator._('dateSubDays', [days]).toString();

  /// Set a date attribute to the current date and time.
  static String dateSetNow() =>
      Operator._('dateSetNow', []).toString();
}
