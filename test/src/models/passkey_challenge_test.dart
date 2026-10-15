import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PasskeyChallenge', () {
    test('model', () {
      final model = PasskeyChallenge(
        $id: "bb8ea5c16897e",
        $createdAt: "2020-10-15T06:38:00.000+00:00",
        passkeyId: "5e5ea5c16897e",
        expire: "2020-10-15T06:38:00.000+00:00",
        publicKey: {},
      );

      final map = model.toMap();
      final result = PasskeyChallenge.fromMap(map);

      expect(result.$id, "bb8ea5c16897e");
      expect(result.$createdAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.passkeyId, "5e5ea5c16897e");
      expect(result.expire, "2020-10-15T06:38:00.000+00:00");
      expect(result.publicKey, {});
    });
  });
}
