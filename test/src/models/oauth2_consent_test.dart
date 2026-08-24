import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2Consent', () {
    test('model', () {
      final model = Oauth2Consent(
        $id: "5e5ea5c16897e",
        $createdAt: "2020-10-15T06:38:00.000+00:00",
        $updatedAt: "2020-10-15T06:38:00.000+00:00",
        userId: "5e5ea5c16897e",
        appId: "5e5ea5c16897e",
        cimdUrl: "https://example.com/.well-known/client-metadata.json",
        scopes: [],
        resources: [],
        authorizationDetails:
            "[{\"type\":\"calendar\",\"identifier\":\"primary\",\"actions\":[\"read_events\",\"create_event\"]}]",
        expire: "2020-10-15T06:38:00.000+00:00",
      );

      final map = model.toMap();
      final result = Oauth2Consent.fromMap(map);

      expect(result.$id, "5e5ea5c16897e");
      expect(result.$createdAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.$updatedAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.userId, "5e5ea5c16897e");
      expect(result.appId, "5e5ea5c16897e");
      expect(
        result.cimdUrl,
        "https://example.com/.well-known/client-metadata.json",
      );
      expect(result.scopes, []);
      expect(result.resources, []);
      expect(
        result.authorizationDetails,
        "[{\"type\":\"calendar\",\"identifier\":\"primary\",\"actions\":[\"read_events\",\"create_event\"]}]",
      );
      expect(result.expire, "2020-10-15T06:38:00.000+00:00");
    });
  });
}
