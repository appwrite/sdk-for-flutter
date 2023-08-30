import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Identity', () {

    test('model', () {
      final model = Identity(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        userId: '5e5bb8c16897e',
        provider: 'email',
        providerUid: '5e5bb8c16897e',
        providerEmail: 'user@example.com',
        providerAccessToken: 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        providerAccessTokenExpiry: '2020-10-15T06:38:00.000+00:00',
        providerRefreshToken: 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
      );

      final map = model.toMap();
      final result = Identity.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.userId, '5e5bb8c16897e');
      expect(result.provider, 'email');
      expect(result.providerUid, '5e5bb8c16897e');
      expect(result.providerEmail, 'user@example.com');
      expect(result.providerAccessToken, 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3');
      expect(result.providerAccessTokenExpiry, '2020-10-15T06:38:00.000+00:00');
      expect(result.providerRefreshToken, 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3');
    });
  });
}
