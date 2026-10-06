import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2Token', () {
    test('model', () {
      final model = Oauth2Token(
        access_token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9...",
        token_type: "Bearer",
        expires_in: 3600,
        refresh_token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
        scope: "openid email profile",
      );

      final map = model.toMap();
      final result = Oauth2Token.fromMap(map);

      expect(result.access_token, "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9...");
      expect(result.token_type, "Bearer");
      expect(result.expires_in, 3600);
      expect(result.refresh_token, "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...");
      expect(result.scope, "openid email profile");
    });
  });
}
