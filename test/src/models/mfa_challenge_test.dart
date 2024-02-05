import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MfaChallenge', () {

    test('model', () {
      final model = MfaChallenge(
        $id: 'bb8ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        userId: '5e5ea5c168bb8',
        expire: '2020-10-15T06:38:00.000+00:00',
      );

      final map = model.toMap();
      final result = MfaChallenge.fromMap(map);

      expect(result.$id, 'bb8ea5c16897e');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.userId, '5e5ea5c168bb8');
      expect(result.expire, '2020-10-15T06:38:00.000+00:00');
    });
  });
}
