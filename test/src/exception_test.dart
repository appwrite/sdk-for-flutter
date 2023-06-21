import 'package:appwrite/src/exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppwriteException', () {
    test('toString should return correct string representation', () {
      final exception1 = AppwriteException();
      expect(exception1.toString(), equals('AppwriteException'));

      final exception2 = AppwriteException('Some error message');
      expect(exception2.toString(), equals('AppwriteException: , Some error message (0)'));

      final exception3 = AppwriteException('Invalid request', 400, 'ValidationError');
      expect(exception3.toString(), equals('AppwriteException: ValidationError, Invalid request (400)'));
    });
  });
}
