import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('unique()', () {
    test('returns unique()', () {
      expect(ID.unique(), 'unique()');
    });
  });

  group('custom()', () {
    test('returns the custom string', () {
      expect(ID.custom('custom'), 'custom');
    });
  });
}
