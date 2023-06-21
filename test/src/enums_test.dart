import 'package:appwrite/src/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('name()', () {
    for (final method in HttpMethod.values) {
      test('returns ${method.toString().split('.').last.toUpperCase()} for $method', () {
        expect(method.name(), method.toString().split('.').last.toUpperCase());
      });
    }
  });
}