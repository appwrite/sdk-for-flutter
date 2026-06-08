import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2Approve', () {
    test('model', () {
      final model = Oauth2Approve(
        redirectUrl: 'https://example.com/callback?code=abcde&state=fghij',
      );

      final map = model.toMap();
      final result = Oauth2Approve.fromMap(map);

            expect(result.redirectUrl, 'https://example.com/callback?code=abcde&state=fghij');
          });
  });
}
