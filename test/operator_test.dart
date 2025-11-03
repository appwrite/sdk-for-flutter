import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns increment', () {
    final op = jsonDecode(Operator.increment(1));
    expect(op['method'], 'increment');
    expect(op['values'], [1]);
  });

  test('returns increment with max', () {
    final op = jsonDecode(Operator.increment(5, 100));
    expect(op['method'], 'increment');
    expect(op['values'], [5, 100]);
  });

  test('returns decrement', () {
    final op = jsonDecode(Operator.decrement(1));
    expect(op['method'], 'decrement');
    expect(op['values'], [1]);
  });

  test('returns decrement with min', () {
    final op = jsonDecode(Operator.decrement(3, 0));
    expect(op['method'], 'decrement');
    expect(op['values'], [3, 0]);
  });

  test('returns multiply', () {
    final op = jsonDecode(Operator.multiply(2));
    expect(op['method'], 'multiply');
    expect(op['values'], [2]);
  });

  test('returns multiply with max', () {
    final op = jsonDecode(Operator.multiply(3, 1000));
    expect(op['method'], 'multiply');
    expect(op['values'], [3, 1000]);
  });

  test('returns divide', () {
    final op = jsonDecode(Operator.divide(2));
    expect(op['method'], 'divide');
    expect(op['values'], [2]);
  });

  test('returns divide with min', () {
    final op = jsonDecode(Operator.divide(4, 1));
    expect(op['method'], 'divide');
    expect(op['values'], [4, 1]);
  });

  test('returns modulo', () {
    final op = jsonDecode(Operator.modulo(5));
    expect(op['method'], 'modulo');
    expect(op['values'], [5]);
  });

  test('returns power', () {
    final op = jsonDecode(Operator.power(2));
    expect(op['method'], 'power');
    expect(op['values'], [2]);
  });

  test('returns power with max', () {
    final op = jsonDecode(Operator.power(3, 100));
    expect(op['method'], 'power');
    expect(op['values'], [3, 100]);
  });

  test('returns arrayAppend', () {
    final op = jsonDecode(Operator.arrayAppend(['item1', 'item2']));
    expect(op['method'], 'arrayAppend');
    expect(op['values'], ['item1', 'item2']);
  });

  test('returns arrayPrepend', () {
    final op = jsonDecode(Operator.arrayPrepend(['first', 'second']));
    expect(op['method'], 'arrayPrepend');
    expect(op['values'], ['first', 'second']);
  });

  test('returns arrayInsert', () {
    final op = jsonDecode(Operator.arrayInsert(0, 'newItem'));
    expect(op['method'], 'arrayInsert');
    expect(op['values'], [0, 'newItem']);
  });

  test('returns arrayRemove', () {
    final op = jsonDecode(Operator.arrayRemove('oldItem'));
    expect(op['method'], 'arrayRemove');
    expect(op['values'], ['oldItem']);
  });

  test('returns arrayUnique', () {
    final op = jsonDecode(Operator.arrayUnique());
    expect(op['method'], 'arrayUnique');
    expect(op['values'], []);
  });

  test('returns arrayIntersect', () {
    final op = jsonDecode(Operator.arrayIntersect(['a', 'b', 'c']));
    expect(op['method'], 'arrayIntersect');
    expect(op['values'], ['a', 'b', 'c']);
  });

  test('returns arrayDiff', () {
    final op = jsonDecode(Operator.arrayDiff(['x', 'y']));
    expect(op['method'], 'arrayDiff');
    expect(op['values'], ['x', 'y']);
  });

  test('returns arrayFilter', () {
    final op = jsonDecode(Operator.arrayFilter(Condition.equal, 'test'));
    expect(op['method'], 'arrayFilter');
    expect(op['values'], ['equal', 'test']);
  });

  test('returns stringConcat', () {
    final op = jsonDecode(Operator.stringConcat('suffix'));
    expect(op['method'], 'stringConcat');
    expect(op['values'], ['suffix']);
  });

  test('returns stringReplace', () {
    final op = jsonDecode(Operator.stringReplace('old', 'new'));
    expect(op['method'], 'stringReplace');
    expect(op['values'], ['old', 'new']);
  });

  test('returns toggle', () {
    final op = jsonDecode(Operator.toggle());
    expect(op['method'], 'toggle');
    expect(op['values'], []);
  });

  test('returns dateAddDays', () {
    final op = jsonDecode(Operator.dateAddDays(7));
    expect(op['method'], 'dateAddDays');
    expect(op['values'], [7]);
  });

  test('returns dateSubDays', () {
    final op = jsonDecode(Operator.dateSubDays(3));
    expect(op['method'], 'dateSubDays');
    expect(op['values'], [3]);
  });

  test('returns dateSetNow', () {
    final op = jsonDecode(Operator.dateSetNow());
    expect(op['method'], 'dateSetNow');
    expect(op['values'], []);
  });
}
