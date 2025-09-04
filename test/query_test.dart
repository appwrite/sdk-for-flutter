import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';

class BasicFilterQueryTest<T> {
  final String description;
  final T value;
  final List<T> expectedValues;

  BasicFilterQueryTest({
    required this.description,
    required this.value,
    required this.expectedValues,
  });
}

void main() {
  group('basic filter tests', () {
    final tests = [
      BasicFilterQueryTest(
        description: 'with a string',
        value: 's',
        expectedValues: ['s'],
      ),
      BasicFilterQueryTest(
        description: 'with an integer',
        value: 1,
        expectedValues: [1],
      ),
      BasicFilterQueryTest(
        description: 'with a double',
        value: 1.2,
        expectedValues: [1.2],
      ),
      BasicFilterQueryTest(
        description: 'with a whole number double',
        value: 1.0,
        expectedValues: [1.0],
      ),
      BasicFilterQueryTest(
        description: 'with a bool',
        value: false,
        expectedValues: [false],
      ),
      BasicFilterQueryTest(
        description: 'with a list',
        value: ['a', 'b', 'c'],
        expectedValues: ['a', 'b', 'c'],
      ),
    ];

    group('equal()', () {
      for (var t in tests) {
        test(t.description, () {
          final query = jsonDecode(Query.equal('attr', t.value));
          expect(query['attribute'], 'attr');
          expect(query['values'], t.expectedValues);
          expect(query['method'], 'equal');
        });
      }
    });

    group('notEqual()', () {
      for (var t in tests) {
        test(
          t.description,
          () {
            final query = jsonDecode(Query.notEqual('attr', t.value));
            expect(query['attribute'], 'attr');
            expect(query['values'], t.expectedValues);
            expect(query['method'], 'notEqual');
          },
          skip: t.value is List,
        );
      }
    });

    group('lessThan()', () {
      for (var t in tests) {
        test(t.description, () {
          final query = jsonDecode(Query.lessThan('attr', t.value));
          expect(query['attribute'], 'attr');
          expect(query['values'], t.expectedValues);
          expect(query['method'], 'lessThan');
        });
      }
    });

    group('lessThanEqual()', () {
      for (var t in tests) {
        test(t.description, () {
          final query = jsonDecode(Query.lessThanEqual('attr', t.value));
          expect(query['attribute'], 'attr');
          expect(query['values'], t.expectedValues);
          expect(query['method'], 'lessThanEqual');
        });
      }
    });

    group('greaterThan()', () {
      for (var t in tests) {
        test(t.description, () {
          final query = jsonDecode(Query.greaterThan('attr', t.value));
          expect(query['attribute'], 'attr');
          expect(query['values'], t.expectedValues);
          expect(query['method'], 'greaterThan');
        });
      }
    });

    group('greaterThanEqual()', () {
      for (var t in tests) {
        test(t.description, () {
          final query = jsonDecode(Query.greaterThanEqual('attr', t.value));
          expect(query['attribute'], 'attr');
          expect(query['values'], t.expectedValues);
          expect(query['method'], 'greaterThanEqual');
        });
      }
    });
  });

  test('returns search', () {
    final query = jsonDecode(Query.search('attr', 'keyword1 keyword2'));
    expect(query['attribute'], 'attr');
    expect(query['values'], ['keyword1 keyword2']);
    expect(query['method'], 'search');
  });

  test('returns isNull', () {
    final query = jsonDecode(Query.isNull('attr'));
    expect(query['attribute'], 'attr');
    expect(query['values'], null);
    expect(query['method'], 'isNull');
  });

  test('returns isNotNull', () {
    final query = jsonDecode(Query.isNotNull('attr'));
    expect(query['attribute'], 'attr');
    expect(query['values'], null);
    expect(query['method'], 'isNotNull');
  });

  group('between()', () {
    test('with integers', () {
      final query = jsonDecode(Query.between('attr', 1, 2));
      expect(query['attribute'], 'attr');
      expect(query['values'], [1, 2]);
      expect(query['method'], 'between');
    });

    test('with doubles', () {
      final query = jsonDecode(Query.between('attr', 1.0, 2.0));
      expect(query['attribute'], 'attr');
      expect(query['values'], [1.0, 2.0]);
      expect(query['method'], 'between');
    });

    test('with strings', () {
      final query = jsonDecode(Query.between('attr', 'a', 'z'));
      expect(query['attribute'], 'attr');
      expect(query['values'], ['a', 'z']);
      expect(query['method'], 'between');
    });
  });

  test('returns select', () {
    final query = jsonDecode(Query.select(['attr1', 'attr2']));
    expect(query['attribute'], null);
    expect(query['values'], ['attr1', 'attr2']);
    expect(query['method'], 'select');
  });

  test('returns orderAsc', () {
    final query = jsonDecode(Query.orderAsc('attr'));
    expect(query['attribute'], 'attr');
    expect(query['values'], null);
    expect(query['method'], 'orderAsc');
  });

  test('returns orderDesc', () {
    final query = jsonDecode(Query.orderDesc('attr'));
    expect(query['attribute'], 'attr');
    expect(query['values'], null);
    expect(query['method'], 'orderDesc');
  });

  test('returns cursorBefore', () {
    final query = jsonDecode(Query.cursorBefore('custom'));
    expect(query['attribute'], null);
    expect(query['values'], ['custom']);
    expect(query['method'], 'cursorBefore');
  });

  test('returns cursorAfter', () {
    final query = jsonDecode(Query.cursorAfter('custom'));
    expect(query['attribute'], null);
    expect(query['values'], ['custom']);
    expect(query['method'], 'cursorAfter');
  });

  test('returns limit', () {
    final query = jsonDecode(Query.limit(1));
    expect(query['attribute'], null);
    expect(query['values'], [1]);
    expect(query['method'], 'limit');
  });

  test('returns offset', () {
    final query = jsonDecode(Query.offset(1));
    expect(query['attribute'], null);
    expect(query['values'], [1]);
    expect(query['method'], 'offset');
  });

  test('returns notContains', () {
    final query = jsonDecode(Query.notContains('attr', 'value'));
    expect(query['attribute'], 'attr');
    expect(query['values'], ['value']);
    expect(query['method'], 'notContains');
  });

  test('returns notSearch', () {
    final query = jsonDecode(Query.notSearch('attr', 'keyword1 keyword2'));
    expect(query['attribute'], 'attr');
    expect(query['values'], ['keyword1 keyword2']);
    expect(query['method'], 'notSearch');
  });

  group('notBetween()', () {
    test('with integers', () {
      final query = jsonDecode(Query.notBetween('attr', 1, 2));
      expect(query['attribute'], 'attr');
      expect(query['values'], [1, 2]);
      expect(query['method'], 'notBetween');
    });

    test('with doubles', () {
      final query = jsonDecode(Query.notBetween('attr', 1.0, 2.0));
      expect(query['attribute'], 'attr');
      expect(query['values'], [1.0, 2.0]);
      expect(query['method'], 'notBetween');
    });

    test('with strings', () {
      final query = jsonDecode(Query.notBetween('attr', 'a', 'z'));
      expect(query['attribute'], 'attr');
      expect(query['values'], ['a', 'z']);
      expect(query['method'], 'notBetween');
    });
  });

  test('returns notStartsWith', () {
    final query = jsonDecode(Query.notStartsWith('attr', 'prefix'));
    expect(query['attribute'], 'attr');
    expect(query['values'], ['prefix']);
    expect(query['method'], 'notStartsWith');
  });

  test('returns notEndsWith', () {
    final query = jsonDecode(Query.notEndsWith('attr', 'suffix'));
    expect(query['attribute'], 'attr');
    expect(query['values'], ['suffix']);
    expect(query['method'], 'notEndsWith');
  });

  test('returns createdBefore', () {
    final query = jsonDecode(Query.createdBefore('2023-01-01'));
    expect(query['attribute'], null);
    expect(query['values'], ['2023-01-01']);
    expect(query['method'], 'createdBefore');
  });

  test('returns createdAfter', () {
    final query = jsonDecode(Query.createdAfter('2023-01-01'));
    expect(query['attribute'], null);
    expect(query['values'], ['2023-01-01']);
    expect(query['method'], 'createdAfter');
  });

  test('returns createdBetween', () {
    final query = jsonDecode(Query.createdBetween('2023-01-01', '2023-12-31'));
    expect(query['attribute'], null);
    expect(query['values'], ['2023-01-01', '2023-12-31']);
    expect(query['method'], 'createdBetween');
  });

  test('returns updatedBefore', () {
    final query = jsonDecode(Query.updatedBefore('2023-01-01'));
    expect(query['attribute'], null);
    expect(query['values'], ['2023-01-01']);
    expect(query['method'], 'updatedBefore');
  });

  test('returns updatedAfter', () {
    final query = jsonDecode(Query.updatedAfter('2023-01-01'));
    expect(query['attribute'], null);
    expect(query['values'], ['2023-01-01']);
    expect(query['method'], 'updatedAfter');
  });

  test('returns updatedBetween', () {
    final query = jsonDecode(Query.updatedBetween('2023-01-01', '2023-12-31'));
    expect(query['attribute'], null);
    expect(query['values'], ['2023-01-01', '2023-12-31']);
    expect(query['method'], 'updatedBetween');
  });
}

