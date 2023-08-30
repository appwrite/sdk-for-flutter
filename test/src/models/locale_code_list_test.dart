import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocaleCodeList', () {

    test('model', () {
      final model = LocaleCodeList(
        total: 5,
        localeCodes: [],
      );

      final map = model.toMap();
      final result = LocaleCodeList.fromMap(map);

      expect(result.total, 5);
      expect(result.localeCodes, []);
    });
  });
}
