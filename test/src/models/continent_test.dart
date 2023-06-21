import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Continent', () {

    test('model', () {
      final model = Continent(
        name: 'Europe',
        code: 'EU',
      );

      final map = model.toMap();
      final result = Continent.fromMap(map);

      expect(result.name, 'Europe');
      expect(result.code, 'EU');
    });
  });
}
