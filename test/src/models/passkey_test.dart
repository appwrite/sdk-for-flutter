import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Passkey', () {
    test('model', () {
      final model = Passkey(
        $id: "5e5ea5c16897e",
        $createdAt: "2020-10-15T06:38:00.000+00:00",
        $updatedAt: "2020-10-15T06:38:00.000+00:00",
        name: "My laptop",
        accessedAt: "2020-10-15T06:38:00.000+00:00",
      );

      final map = model.toMap();
      final result = Passkey.fromMap(map);

      expect(result.$id, "5e5ea5c16897e");
      expect(result.$createdAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.$updatedAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.name, "My laptop");
      expect(result.accessedAt, "2020-10-15T06:38:00.000+00:00");
    });
  });
}
