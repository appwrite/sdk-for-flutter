import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Headers', () {

    test('model', () {
      final model = Headers(
        name: 'Content-Type',
        value: 'application/json',
      );

      final map = model.toMap();
      final result = Headers.fromMap(map);

      expect(result.name, 'Content-Type');
      expect(result.value, 'application/json');
    });
  });
}
