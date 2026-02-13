import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('KeyList', () {
    test('model', () {
      final model = KeyList(
        total: 5,
        keys: [],
      );

      final map = model.toMap();
      final result = KeyList.fromMap(map);

      expect(result.total, 5);
      expect(result.keys, []);
    });
  });
}
