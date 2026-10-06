import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppKeyList', () {
    test('model', () {
      final model = AppKeyList(
        total: 5,
        keys: [],
      );

      final map = model.toMap();
      final result = AppKeyList.fromMap(map);

      expect(result.total, 5);
      expect(result.keys, []);
    });
  });
}
