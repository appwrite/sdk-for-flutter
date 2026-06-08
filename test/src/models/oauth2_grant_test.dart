import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2Grant', () {
    test('model', () {
      final model = Oauth2Grant(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        userId: '5e5ea5c16897e',
        appId: '5e5ea5c16897e',
        scopes: [],
        authorizationDetails: '[{\"type\":\"calendar\",\"identifier\":\"primary\",\"actions\":[\"read_events\",\"create_event\"]}]',
        prompt: 'login',
        redirectUri: 'https://example.com/callback',
        authTime: 1592981250,
        expire: '2020-10-15T06:38:00.000+00:00',
      );

      final map = model.toMap();
      final result = Oauth2Grant.fromMap(map);

            expect(result.$id, '5e5ea5c16897e');
                  expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.userId, '5e5ea5c16897e');
                  expect(result.appId, '5e5ea5c16897e');
                  expect(result.scopes, []);
                  expect(result.authorizationDetails, '[{\"type\":\"calendar\",\"identifier\":\"primary\",\"actions\":[\"read_events\",\"create_event\"]}]');
                  expect(result.prompt, 'login');
                  expect(result.redirectUri, 'https://example.com/callback');
                  expect(result.authTime, 1592981250);
                  expect(result.expire, '2020-10-15T06:38:00.000+00:00');
          });
  });
}
