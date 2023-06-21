import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Locale', () {

    test('model', () {
      final model = Locale(
        ip: '127.0.0.1',
        countryCode: 'US',
        country: 'United States',
        continentCode: 'NA',
        continent: 'North America',
        eu: true,
        currency: 'USD',
      );

      final map = model.toMap();
      final result = Locale.fromMap(map);

      expect(result.ip, '127.0.0.1');
      expect(result.countryCode, 'US');
      expect(result.country, 'United States');
      expect(result.continentCode, 'NA');
      expect(result.continent, 'North America');
      expect(result.eu, true);
      expect(result.currency, 'USD');
    });
  });
}
