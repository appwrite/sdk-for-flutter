import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Presence', () {
    test('model', () {
      final model = Presence(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        $permissions: [],
        userId: '674af8f3e12a5f9ac0be',
        source: 'HTTP',
        metadata: {},
      );

      final map = model.toMap();
      final result = Presence.fromMap(map);

            expect(result.$id, '5e5ea5c16897e');
                  expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$permissions, []);
                  expect(result.userId, '674af8f3e12a5f9ac0be');
                  expect(result.source, 'HTTP');
          });
  });
}
