import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Row', () {
    test('model', () {
      final model = Row(
        $id: '5e5ea5c16897e',
        $sequence: 1,
        $tableId: '5e5ea5c15117e',
        $databaseId: '5e5ea5c15117e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        $permissions: [],
        data: {},
      );

      final map = model.toMap();
      final result = Row.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$sequence, 1);
      expect(result.$tableId, '5e5ea5c15117e');
      expect(result.$databaseId, '5e5ea5c15117e');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$permissions, []);
    });
  });
}
