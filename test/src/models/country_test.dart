import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Country', () {

    test('model', () {
      final model = Country(
        name: 'United States',
        code: 'US',
      );

      final map = model.toMap();
      final result = Country.fromMap(map);

      expect(result.name, 'United States');
      expect(result.code, 'US');
    });
  });
}
