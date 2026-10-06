import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    test('model', () {
      final model = App(
        $id: "5e5ea5c16897e",
        $createdAt: "2020-10-15T06:38:00.000+00:00",
        $updatedAt: "2020-10-15T06:38:00.000+00:00",
        name: "My Application",
        description: "Connect your workspace to My Application.",
        clientUri: "https://example.com",
        logoUri: "https://example.com/logo.png",
        privacyPolicyUrl: "https://example.com/privacy",
        termsUrl: "https://example.com/terms",
        contacts: [],
        tagline: "Automate your workspace.",
        tags: [],
        labels: [],
        images: [],
        supportUrl: "https://example.com/support",
        dataDeletionUrl: "https://example.com/data-deletion",
        redirectUris: [],
        postLogoutRedirectUris: [],
        enabled: true,
        type: "confidential",
        deviceFlow: true,
        teamId: "5e5ea5c16897e",
        userId: "5e5ea5c16897e",
        installationScopes: [],
        installationRedirectUrl: "https://example.com/setup",
        secrets: [],
      );

      final map = model.toMap();
      final result = App.fromMap(map);

      expect(result.$id, "5e5ea5c16897e");
      expect(result.$createdAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.$updatedAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.name, "My Application");
      expect(result.description, "Connect your workspace to My Application.");
      expect(result.clientUri, "https://example.com");
      expect(result.logoUri, "https://example.com/logo.png");
      expect(result.privacyPolicyUrl, "https://example.com/privacy");
      expect(result.termsUrl, "https://example.com/terms");
      expect(result.contacts, []);
      expect(result.tagline, "Automate your workspace.");
      expect(result.tags, []);
      expect(result.labels, []);
      expect(result.images, []);
      expect(result.supportUrl, "https://example.com/support");
      expect(result.dataDeletionUrl, "https://example.com/data-deletion");
      expect(result.redirectUris, []);
      expect(result.postLogoutRedirectUris, []);
      expect(result.enabled, true);
      expect(result.type, "confidential");
      expect(result.deviceFlow, true);
      expect(result.teamId, "5e5ea5c16897e");
      expect(result.userId, "5e5ea5c16897e");
      expect(result.installationScopes, []);
      expect(result.installationRedirectUrl, "https://example.com/setup");
      expect(result.secrets, []);
    });
  });
}
