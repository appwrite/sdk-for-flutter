import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2PAR', () {
    test('model', () {
      final model = Oauth2PAR(
        request_uri: "urn:appwrite:oauth2:request:5e5ea5c16897e",
        expires_in: 600,
      );

      final map = model.toMap();
      final result = Oauth2PAR.fromMap(map);

      expect(result.request_uri, "urn:appwrite:oauth2:request:5e5ea5c16897e");
      expect(result.expires_in, 600);
    });
  });
}
