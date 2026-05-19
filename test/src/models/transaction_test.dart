import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Transaction', () {
    test('model', () {
      final model = Transaction(
        $id: '259125845563242502',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        status: 'pending',
        operations: 5,
        expiresAt: '2020-10-15T06:38:00.000+00:00',
      );

      final map = model.toMap();
      final result = Transaction.fromMap(map);

      expect(result.$id, '259125845563242502');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.status, 'pending');
      expect(result.operations, 5);
      expect(result.expiresAt, '2020-10-15T06:38:00.000+00:00');
    });
  });
}
