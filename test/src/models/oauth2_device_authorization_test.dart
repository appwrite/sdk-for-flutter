import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2DeviceAuthorization', () {
    test('model', () {
      final model = Oauth2DeviceAuthorization(
        device_code:
            "5f3c8d2a1b9e4f7a6c8b2d1e9f4a7b3c5d8e1f2a9b4c7d6e3f5a8b1c4d7e2f9a",
        user_code: "ABCD-EFGH",
        verification_uri: "https://appwrite.io/oauth2/device",
        verification_uri_complete:
            "https://appwrite.io/oauth2/device?user_code=ABCD-EFGH",
        expires_in: 900,
        interval: 5,
      );

      final map = model.toMap();
      final result = Oauth2DeviceAuthorization.fromMap(map);

      expect(
        result.device_code,
        "5f3c8d2a1b9e4f7a6c8b2d1e9f4a7b3c5d8e1f2a9b4c7d6e3f5a8b1c4d7e2f9a",
      );
      expect(result.user_code, "ABCD-EFGH");
      expect(result.verification_uri, "https://appwrite.io/oauth2/device");
      expect(
        result.verification_uri_complete,
        "https://appwrite.io/oauth2/device?user_code=ABCD-EFGH",
      );
      expect(result.expires_in, 900);
      expect(result.interval, 5);
    });
  });
}
