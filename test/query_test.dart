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

  test('returns orderRandom', () {
    final query = jsonDecode(Query.orderRandom());
    expect(query['attribute'], null);
    expect(query['values'], null);
    expect(query['method'], 'orderRandom');
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

  test('returns regex', () {
    final query = jsonDecode(Query.regex('attr', 'pattern.*'));
    expect(query['attribute'], 'attr');
    expect(query['values'], ['pattern.*']);
    expect(query['method'], 'regex');
  });

  test('returns exists', () {
    final query = jsonDecode(Query.exists(['attr1', 'attr2']));
    expect(query['attribute'], null);
    expect(query['values'], ['attr1', 'attr2']);
    expect(query['method'], 'exists');
  });

  test('returns notExists', () {
    final query = jsonDecode(Query.notExists(['attr1', 'attr2']));
    expect(query['attribute'], null);
    expect(query['values'], ['attr1', 'attr2']);
    expect(query['method'], 'notExists');
  });

  test('returns elemMatch', () {
    final inner1 = Query.equal('name', 'Alice');
    final inner2 = Query.greaterThan('age', 18);

    final query = jsonDecode(Query.elemMatch('friends', [inner1, inner2]));

    expect(query['attribute'], 'friends');
    expect(query['method'], 'elemMatch');
    expect(query['values'].length, 2);

    expect(query['values'][0]['method'], 'equal');
    expect(query['values'][0]['attribute'], 'name');
    expect(query['values'][0]['values'], ['Alice']);

    expect(query['values'][1]['method'], 'greaterThan');
    expect(query['values'][1]['attribute'], 'age');
    expect(query['values'][1]['values'], [18]);
  });

  test('returns relationship', () {
    final inner1 = Query.equal('approved', true);
    final inner2 = Query.limit(2);

    final query = jsonDecode(Query.relationship('comments', [inner1, inner2]));

    expect(query['attribute'], 'comments');
    expect(query['method'], 'relationship');
    expect(query['values'].length, 2);

    expect(query['values'][0]['method'], 'equal');
    expect(query['values'][0]['attribute'], 'approved');
    expect(query['values'][0]['values'], [true]);

    expect(query['values'][1]['method'], 'limit');
    expect(query['values'][1]['values'], [2]);
  });

  test('returns createdBefore', () {
    final query = jsonDecode(Query.createdBefore('2023-01-01'));
    expect(query['attribute'], '\$createdAt');
    expect(query['values'], ['2023-01-01']);
    expect(query['method'], 'lessThan');
  });

  test('returns createdAfter', () {
    final query = jsonDecode(Query.createdAfter('2023-01-01'));
    expect(query['attribute'], '\$createdAt');
    expect(query['values'], ['2023-01-01']);
    expect(query['method'], 'greaterThan');
  });

  test('returns createdBetween', () {
    final query = jsonDecode(Query.createdBetween('2023-01-01', '2023-12-31'));
    expect(query['attribute'], '\$createdAt');
    expect(query['values'], ['2023-01-01', '2023-12-31']);
    expect(query['method'], 'between');
  });

  test('returns updatedBefore', () {
    final query = jsonDecode(Query.updatedBefore('2023-01-01'));
    expect(query['attribute'], '\$updatedAt');
    expect(query['values'], ['2023-01-01']);
    expect(query['method'], 'lessThan');
  });

  test('returns updatedAfter', () {
    final query = jsonDecode(Query.updatedAfter('2023-01-01'));
    expect(query['attribute'], '\$updatedAt');
    expect(query['values'], ['2023-01-01']);
    expect(query['method'], 'greaterThan');
  });

  test('returns updatedBetween', () {
    final query = jsonDecode(Query.updatedBetween('2023-01-01', '2023-12-31'));
    expect(query['attribute'], '\$updatedAt');
    expect(query['values'], ['2023-01-01', '2023-12-31']);
    expect(query['method'], 'between');
  });

  test('returns count with alias', () {
    final query = jsonDecode(Query.count('*', 'total'));
    expect(query['method'], 'count');
    expect(query['attribute'], '*');
    expect(query['values'], ['total']);
  });

  test('returns count without alias', () {
    final query = jsonDecode(Query.count());
    expect(query['method'], 'count');
    expect(query['attribute'], '*');
    expect(query.containsKey('values'), isFalse);
  });

  test('returns countDistinct', () {
    final query = jsonDecode(Query.countDistinct('year', 'uniqueYears'));
    expect(query['method'], 'countDistinct');
    expect(query['attribute'], 'year');
    expect(query['values'], ['uniqueYears']);
  });

  test('returns sum avg min max', () {
    expect(jsonDecode(Query.sum('price', 'total'))['method'], 'sum');
    expect(jsonDecode(Query.avg('price', 'avgPrice'))['method'], 'avg');
    expect(jsonDecode(Query.min('price', 'lowest'))['method'], 'min');
    expect(jsonDecode(Query.max('price', 'highest'))['method'], 'max');
  });

  test('returns stddev', () {
    expect(jsonDecode(Query.stddev('price', 'sd'))['method'], 'stddev');
  });

  test('returns stddevPop', () {
    expect(jsonDecode(Query.stddevPop('price', 'sdp'))['method'], 'stddevPop');
  });

  test('returns stddevSamp', () {
    expect(jsonDecode(Query.stddevSamp('price', 'sds'))['method'], 'stddevSamp');
  });

  test('returns variance', () {
    expect(jsonDecode(Query.variance('price', 'var'))['method'], 'variance');
  });

  test('returns varPop', () {
    expect(jsonDecode(Query.varPop('price', 'vp'))['method'], 'varPop');
  });

  test('returns varSamp', () {
    expect(jsonDecode(Query.varSamp('price', 'vs'))['method'], 'varSamp');
  });

  test('returns bitAnd', () {
    expect(jsonDecode(Query.bitAnd('flags', 'band'))['method'], 'bitAnd');
  });

  test('returns bitOr', () {
    expect(jsonDecode(Query.bitOr('flags', 'bor'))['method'], 'bitOr');
  });

  test('returns bitXor', () {
    expect(jsonDecode(Query.bitXor('flags', 'bxor'))['method'], 'bitXor');
  });

  test('returns groupBy', () {
    final query = jsonDecode(Query.groupBy(['status', 'year']));
    expect(query['method'], 'groupBy');
    expect(query['values'], ['status', 'year']);
    expect(query.containsKey('attribute'), isFalse);
  });

  test('returns having', () {
    final query = jsonDecode(Query.having([Query.greaterThan('total', 1)]));
    expect(query['method'], 'having');
    expect(query['values'][0]['method'], 'greaterThan');
    expect(query['values'][0]['attribute'], 'total');
    expect(query['values'][0]['values'], [1]);
  });

  test('returns distinct', () {
    final query = jsonDecode(Query.distinct());
    expect(query['method'], 'distinct');
    expect(query.containsKey('attribute'), isFalse);
    expect(query.containsKey('values'), isFalse);
  });

  test('returns join', () {
    final query = jsonDecode(Query.join('orders', '\$id', 'customerId'));
    expect(query['method'], 'join');
    expect(query['attribute'], 'orders');
    expect(query['values'], ['\$id', '=', 'customerId']);
  });

  test('returns leftJoin with alias', () {
    final query = jsonDecode(
      Query.leftJoin('orders', '\$id', 'customerId', '=', 'ord'),
    );
    expect(query['method'], 'leftJoin');
    expect(query['attribute'], 'orders');
    expect(query['values'], ['\$id', '=', 'customerId', 'ord']);
  });

  test('returns rightJoin', () {
    final query = jsonDecode(Query.rightJoin('orders', '\$id', 'customerId'));
    expect(query['method'], 'rightJoin');
    expect(query['values'], ['\$id', '=', 'customerId']);
  });

  test('returns fullOuterJoin', () {
    final query = jsonDecode(Query.fullOuterJoin('orders', '\$id', 'customerId'));
    expect(query['method'], 'fullOuterJoin');
    expect(query['values'], ['\$id', '=', 'customerId']);
  });

  test('returns on', () {
    final query = jsonDecode(Query.on('\$id', 'customerId'));
    expect(query['method'], 'on');
    expect(query['values'], ['\$id', '=', 'customerId']);
  });

  test('returns nested leftJoin', () {
    final query = jsonDecode(Query.leftJoin('orders', 'ord', [
      Query.on('\$id', 'customerId'),
      Query.equal('ord.status', 'paid'),
    ]));
    expect(query['method'], 'leftJoin');
    expect(query['attribute'], 'orders');
    expect(query['values'][0], 'ord');
    expect(query['values'][1]['method'], 'on');
    expect(query['values'][2]['method'], 'equal');
  });

  test('returns crossJoin', () {
    final query = jsonDecode(Query.crossJoin('orders', 'ord'));
    expect(query['method'], 'crossJoin');
    expect(query['attribute'], 'orders');
    expect(query['values'], ['ord']);
  });

  test('returns nested join without alias, leaving the alias to the server',
      () {
    final query =
        jsonDecode(Query.join('orders', [Query.on('\$id', 'customerId')]));
    expect(query['method'], 'join');
    expect(query['attribute'], 'orders');
    expect(query['values'].length, 1);
    expect(query['values'][0]['method'], 'on');
  });

  test('returns crossJoin without alias, leaving the alias to the server', () {
    final query = jsonDecode(Query.crossJoin('orders'));
    expect(query['method'], 'crossJoin');
    expect(query['attribute'], 'orders');
    expect(query['values'] ?? [], isEmpty);
  });

  test('returns vectorDot', () {
    final query = jsonDecode(Query.vectorDot('embedding', [0.1, 0.2]));
    expect(query['method'], 'vectorDot');
    expect(query['attribute'], 'embedding');
    expect(query['values'], [
      [0.1, 0.2]
    ]);
  });

  test('returns covers', () {
    final query = jsonDecode(Query.covers('location', [0, 0]));
    expect(query['method'], 'covers');
    expect(query['values'], [
      [0, 0]
    ]);
  });

  test('returns notCovers', () {
    final query = jsonDecode(Query.notCovers('location', [1, 2]));
    expect(query['method'], 'notCovers');
    expect(query['values'], [
      [1, 2]
    ]);
  });

  test('returns spatialEquals', () {
    final query = jsonDecode(Query.spatialEquals('location', [1, 2]));
    expect(query['method'], 'spatialEquals');
    expect(query['values'], [
      [1, 2]
    ]);
  });

  test('returns notSpatialEquals', () {
    final query = jsonDecode(Query.notSpatialEquals('location', [1, 2]));
    expect(query['method'], 'notSpatialEquals');
    expect(query['values'], [
      [1, 2]
    ]);
  });

  test('returns page', () {
    final queries = Query.page(2, 10);
    expect(queries.length, 2);
    final limit = jsonDecode(queries[0]);
    final offset = jsonDecode(queries[1]);
    expect(limit['method'], 'limit');
    expect(limit['values'], [10]);
    expect(offset['method'], 'offset');
    expect(offset['values'], [10]);
  });

  test('page rejects invalid', () {
    expect(() => Query.page(0, 10), throwsA(isA<ArgumentError>()));
    expect(() => Query.page(1, 0), throwsA(isA<ArgumentError>()));
  });

  test('builder build', () {
    final expected = [
      Query.equal('status', 'published'),
      Query.leftJoin('orders', '\$id', 'customerId', '=', 'ord'),
      Query.count('*', 'total'),
      Query.groupBy(['status']),
      Query.limit(25),
    ];

    final built = Query.builder()
        .equal('status', 'published')
        .leftJoin('orders', '\$id', 'customerId', '=', 'ord')
        .count('*', 'total')
        .groupBy(['status'])
        .limit(25)
        .build();

    expect(built, expected);
  });
}
