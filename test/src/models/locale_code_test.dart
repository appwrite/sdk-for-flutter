import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocaleCode', () {

    test('model', () {
      final model = LocaleCode(
        code: 'en-us',
        name: 'US',
      );

      final map = model.toMap();
      final result = LocaleCode.fromMap(map);

      expect(result.code, 'en-us');
      expect(result.name, 'US');
    });
  });
}
