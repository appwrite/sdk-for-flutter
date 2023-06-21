import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Currency', () {

    test('model', () {
      final model = Currency(
        symbol: '\$',
        name: 'US dollar',
        symbolNative: '\$',
        decimalDigits: 2,
        rounding: 0,
        code: 'USD',
        namePlural: 'US dollars',
      );

      final map = model.toMap();
      final result = Currency.fromMap(map);

      expect(result.symbol, '\$');
      expect(result.name, 'US dollar');
      expect(result.symbolNative, '\$');
      expect(result.decimalDigits, 2);
      expect(result.rounding, 0);
      expect(result.code, 'USD');
      expect(result.namePlural, 'US dollars');
    });
  });
}
