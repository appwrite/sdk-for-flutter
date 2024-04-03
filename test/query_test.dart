import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('basic filter tests', () {
    final tests = [
      BasicFilterQueryTest(
        description: 'with a string',
        value: 's',
        expectedValues: ["s"],
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
        expectedValues: ["a", "b", "c"],
      ),
    ];

    group('equal()', () {
      for (var t in tests) {
        test(t.description, () {
          final query = Query.equal('attr', t.value).toJson();
          expect(query['attribute'], 'attr');
          expect(query['values'], t.expectedValues);
          expect(query['method'], 'equal');
        });
      }
    });

    group('notEqual()', () {
      for (var t in tests) {
        test(t.description, () {
          final query = Query.notEqual('attr', t.value).toJson();
          expect(query['attribute'], 'attr');
          expect(query['values'], t.expectedValues);
          expect(query['method'], 'notEqual');
        });
      }
    });

    group('lessThan()', () {
      for (var t in tests) {
        test(t.description, () {
          final query = Query.lessThan('attr', t.value).toJson();
          expect(query['attribute'], 'attr');
          expect(query['values'], t.expectedValues);
          expect(query['method'], 'lessThan');
        });
      }
    });

    group('lessThanEqual()', () {
      for (var t in tests) {
        test(t.description, () {
          final query = Query.lessThanEqual('attr', t.value).toJson();
          expect(query['attribute'], 'attr');
          expect(query['values'], t.expectedValues);
          expect(query['method'], 'lessThanEqual');
        });
      }
    });

    group('greaterThan()', () {
      for (var t in tests) {
        test(t.description, () {
          final query = Query.greaterThan('attr', t.value).toJson();
          expect(query['attribute'], 'attr');
          expect(query['values'], t.expectedValues);
          expect(query['method'], 'greaterThan');
        });
      }
    });

    group('greaterThanEqual()', () {
      for (var t in tests) {
        test(t.description, () {
          final query = Query.greaterThanEqual('attr', t.value).toJson();
          expect(query['attribute'], 'attr');
          expect(query['values'], t.expectedValues);
          expect(query['method'], 'greaterThanEqual');
        });
      }
    });
  });

  test('returns search', () {
    final query = Query.search('attr', 'keyword1 keyword2').toJson();
    expect(query['attribute'], 'attr');
    expect(query['values'], ['keyword1 keyword2']);
    expect(query['method'], 'search');
  });

  test('returns isNull', () {
    final query = Query.isNull('attr').toJson();
    expect(query['attribute'], 'attr');
    expect(query['values'], null);
    expect(query['method'], 'isNull');
  });

  test('returns isNotNull', () {
    final query = Query.isNotNull('attr', 'keyword1 keyword2').toJson();
    expect(query['attribute'], 'attr');
    expect(query['values'], null);
    expect(query['method'], 'isNotNull');
  });

  group('between()', () {
    test('with integers', () {
      final query = Query.between('attr', 1, 2).toJson();
      expect(query['attribute'], 'attr');
      expect(query['values'], [1, 2]);
      expect(query['method'], 'between');
    });

    test('with doubles', () {
      final query = Query.between('attr', 1.0, 2.0).toJson();
      expect(query['attribute'], 'attr');
      expect(query['values'], [1.0, 2.0]);
      expect(query['method'], 'between');
    });

    test('with strings', () {
      final query = Query.between('attr', 'a', 'z').toJson();
      expect(query['attribute'], 'attr');
      expect(query['values'], ['a', 'z']);
      expect(query['method'], 'between');
    });
  });

  test('returns select', () {
    final query = Query.select(['attr1', 'attr2']).toJson();
    expect(query['attribute'], null);
    expect(query['values'], ['attr1', 'attr2']);
    expect(query['method'], 'select');
  });

  test('returns orderAsc', () {
    final query = Query.orderAsc('attr').toJson();
    expect(query['attribute'], 'attr');
    expect(query['values'], null);
    expect(query['method'], 'orderAsc');
  });

  test('returns orderDesc', () {
    final query = Query.orderDesc('attr').toJson();
    expect(query['attribute'], 'attr');
    expect(query['values'], null);
    expect(query['method'], 'orderDesc');
  });

  test('returns cursorBefore', () {
    final query = Query.cursorBefore('custom').toJson();
    expect(query['attribute'], null);
    expect(query['values'], 'custom');
    expect(query['method'], 'cursorBefore');
  });

  test('returns cursorAfter', () {
    final query = Query.cursorAfter('custom').toJson();
    expect(query['attribute'], null);
    expect(query['values'], 'custom');
    expect(query['method'], 'cursorAfter');
  });

  test('returns limit', () {
    final query = Query.limit(1).toJson();
    expect(query['attribute'], null);
    expect(query['values'], 1);
    expect(query['method'], 'limit');
  });

  test('returns offset', () {
    final query = Query.offset(1).toJson();
    expect(query['attribute'], null);
    expect(query['values'], 1);
    expect(query['method'], 'offset');
  });
}

class BasicFilterQueryTest {
  final String description;
  final dynamic value;
  final String expectedValues;

  BasicFilterQueryTest({
    required this.description,
    required this.value,
    required this.expectedValues,
  });
}
