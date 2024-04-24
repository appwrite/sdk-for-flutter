import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('unique()', () {
    test('returns unique ID', () {
      expect((ID.unique()).length, 20);
    });
  });

  group('custom()', () {
    test('returns the custom string', () {
      expect(ID.custom('custom'), 'custom');
    });
  });
}
