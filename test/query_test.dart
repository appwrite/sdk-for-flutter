import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';

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

void main() {
  group('basic filter tests', () {
    final tests = [
      BasicFilterQueryTest(
        description: 'with a string',
        value: 's',
        expectedValues: '["s"]',
      ),
      BasicFilterQueryTest(
        description: 'with an integer',
        value: 1,
        expectedValues: '[1]',
      ),
      BasicFilterQueryTest(
        description: 'with a double',
        value: 1.2,
        expectedValues: '[1.2]',
      ),
      BasicFilterQueryTest(
        description: 'with a whole number double',
        value: 1.0,
        expectedValues: '[1.0]',
      ),
      BasicFilterQueryTest(
        description: 'with a bool',
        value: false,
        expectedValues: '[false]',
      ),
      BasicFilterQueryTest(
        description: 'with a list',
        value: ['a', 'b', 'c'],
        expectedValues: '["a","b","c"]',
      ),
    ];

    group('equal()', () {
      for (var t in tests) {
        test(t.description, () {
          expect(
            Query.equal('attr', t.value),
            'equal("attr", ${t.expectedValues})',
          );
        });
      }
    });

    group('notEqual()', () {
      for (var t in tests) {
        test(t.description, () {
          expect(
            Query.notEqual('attr', t.value),
            'notEqual("attr", ${t.expectedValues})',
          );
        });
      }
    });

    group('lessThan()', () {
      for (var t in tests) {
        test(t.description, () {
          expect(
            Query.lessThan('attr', t.value),
            'lessThan("attr", ${t.expectedValues})',
          );
        });
      }
    });

    group('lessThanEqual()', () {
      for (var t in tests) {
        test(t.description, () {
          expect(
            Query.lessThanEqual('attr', t.value),
            'lessThanEqual("attr", ${t.expectedValues})',
          );
        });
      }
    });

    group('greaterThan()', () {
      for (var t in tests) {
        test(t.description, () {
          expect(
            Query.greaterThan('attr', t.value),
            'greaterThan("attr", ${t.expectedValues})',
          );
        });
      }
    });

    group('greaterThanEqual()', () {
      for (var t in tests) {
        test(t.description, () {
          expect(
            Query.greaterThanEqual('attr', t.value),
            'greaterThanEqual("attr", ${t.expectedValues})',
          );
        });
      }
    });
  });

  group('search()', () {
    test('returns search', () {
      expect(Query.search('attr', 'keyword1 keyword2'), 'search("attr", ["keyword1 keyword2"])');
    });
  });

  group('isNull()', () {
    test('returns isNull', () {
      expect(Query.isNull('attr'), 'isNull("attr")');
    });
  });

  group('isNotNull()', () {
    test('returns isNotNull', () {
      expect(Query.isNotNull('attr'), 'isNotNull("attr")');
    });
  });

  group('between()', () {
    test('with integers', () {
      expect(Query.between('attr', 1, 2), 'between("attr", [1,2])');
    });

    test('with doubles', () {
      expect(Query.between('attr', 1.0, 2.0), 'between("attr", [1.0,2.0])');
    });

    test('with strings', () {
      expect(Query.between('attr', "a", "z"), 'between("attr", ["a","z"])');
    });
  });

  group('select()', () {
    test('returns select', () {
      expect(Query.select(['attr1', 'attr2']), 'select(["attr1","attr2"])');
    });
  });

  group('orderAsc()', () {
    test('returns orderAsc', () {
      expect(Query.orderAsc('attr'), 'orderAsc("attr")');
    });
  });

  group('orderDesc()', () {
    test('returns orderDesc', () {
      expect(Query.orderDesc('attr'), 'orderDesc("attr")');
    });
  });

  group('cursorBefore()', () {
    test('returns cursorBefore', () {
      expect(Query.cursorBefore(ID.custom('custom')), 'cursorBefore("custom")');
    });
  });

  group('cursorAfter()', () {
    test('returns cursorAfter', () {
      expect(Query.cursorAfter(ID.custom('custom')), 'cursorAfter("custom")');
    });
  });

  group('limit()', () {
    test('returns limit', () {
      expect(Query.limit(1), 'limit(1)');
    });
  });

  group('offset()', () {
    test('returns offset', () {
      expect(Query.offset(1), 'offset(1)');
    });
  });
}

