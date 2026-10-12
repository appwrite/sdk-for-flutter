import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TokenSecret', () {
    test('model', () {
      final model = TokenSecret(
        $id: "bb8ea5c16897e",
        $createdAt: "2020-10-15T06:38:00.000+00:00",
        userId: "5e5ea5c168bb8",
        secret: "",
        expire: "2020-10-15T06:38:00.000+00:00",
        phrase: "Golden Fox",
      );

      final map = model.toMap();
      final result = TokenSecret.fromMap(map);

      expect(result.$id, "bb8ea5c16897e");
      expect(result.$createdAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.userId, "5e5ea5c168bb8");
      expect(result.secret, "");
      expect(result.expire, "2020-10-15T06:38:00.000+00:00");
      expect(result.phrase, "Golden Fox");
    });
  });
}
