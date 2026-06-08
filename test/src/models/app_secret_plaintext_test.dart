import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSecretPlaintext', () {
    test('model', () {
      final model = AppSecretPlaintext(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        appId: '5e5ea5c16897e',
        secret:
            '5f3c8d2a1b9e4f7a6c8b2d1e9f4a7b3c5d8e1f2a9b4c7d6e3f5a8b1c4d7e2f9a',
        hint: 'f5c6c7',
        createdById: '5e5ea5c16897e',
        createdByName: 'Walter White',
      );

      final map = model.toMap();
      final result = AppSecretPlaintext.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.appId, '5e5ea5c16897e');
      expect(result.secret,
          '5f3c8d2a1b9e4f7a6c8b2d1e9f4a7b3c5d8e1f2a9b4c7d6e3f5a8b1c4d7e2f9a');
      expect(result.hint, 'f5c6c7');
      expect(result.createdById, '5e5ea5c16897e');
      expect(result.createdByName, 'Walter White');
    });
  });
}
