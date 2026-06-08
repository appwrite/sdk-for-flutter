import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    test('model', () {
      final model = App(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        name: 'My Application',
        redirectUris: [],
        enabled: true,
        type: 'confidential',
        deviceFlow: true,
        teamId: '5e5ea5c16897e',
        userId: '5e5ea5c16897e',
        secrets: [],
      );

      final map = model.toMap();
      final result = App.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.name, 'My Application');
      expect(result.redirectUris, []);
      expect(result.enabled, true);
      expect(result.type, 'confidential');
      expect(result.deviceFlow, true);
      expect(result.teamId, '5e5ea5c16897e');
      expect(result.userId, '5e5ea5c16897e');
      expect(result.secrets, []);
    });
  });
}
