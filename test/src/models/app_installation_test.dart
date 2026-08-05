import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppInstallation', () {
    test('model', () {
      final model = AppInstallation(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        appId: '5e5ea5c16897e',
        teamId: '5e5ea5c16897e',
        scopes: [],
        authorizationDetails: {},
        createdById: '5e5ea5c16897e',
        createdByName: 'Walter White',
      );

      final map = model.toMap();
      final result = AppInstallation.fromMap(map);

            expect(result.$id, '5e5ea5c16897e');
                  expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.appId, '5e5ea5c16897e');
                  expect(result.teamId, '5e5ea5c16897e');
                  expect(result.scopes, []);
                  expect(result.authorizationDetails, {});
                  expect(result.createdById, '5e5ea5c16897e');
                  expect(result.createdByName, 'Walter White');
          });
  });
}
