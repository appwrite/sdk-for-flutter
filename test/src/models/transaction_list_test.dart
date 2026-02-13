import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransactionList', () {
    test('model', () {
      final model = TransactionList(
        total: 5,
        transactions: [],
      );

      final map = model.toMap();
      final result = TransactionList.fromMap(map);

      expect(result.total, 5);
      expect(result.transactions, []);
    });
  });
}
