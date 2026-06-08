import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2Reject', () {
    test('model', () {
      final model = Oauth2Reject(
        redirectUrl: 'https://example.com/callback?error=access_denied&state=fghij',
      );

      final map = model.toMap();
      final result = Oauth2Reject.fromMap(map);

            expect(result.redirectUrl, 'https://example.com/callback?error=access_denied&state=fghij');
          });
  });
}
