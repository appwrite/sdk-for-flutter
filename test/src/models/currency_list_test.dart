import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyList', () {

    test('model', () {
      final model = CurrencyList(
        total: 5,
        currencies: [],
      );

      final map = model.toMap();
      final result = CurrencyList.fromMap(map);

      expect(result.total, 5);
      expect(result.currencies, []);
    });
  });
}
