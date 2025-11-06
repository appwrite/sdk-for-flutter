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

    // Test for the specific bug
    //reported in issue #281
    test('fromMap should handle columns named data without type errors', () {
      final map = {
        '\$id': 'row123',
        '\$sequence': 1,
        '\$tableId': 'table1',
        '\$databaseId': 'db1',
        '\$createdAt': '2023-01-01T00:00:00.000Z',
        '\$updatedAt': '2023-01-01T00:00:00.000Z',
        '\$permissions': ['read', 'write'],
        'data':
            'this is a string value in data column', // This column name was causing the issue
        'name': 'Test Row',
        'value': 42,
      };

      // This should not throw a TypeError anymore
      final row = Row.fromMap(map);

      // Verify that data contains the complete map
      expect(row.data, isA<Map<String, dynamic>>());
      expect(row.data['data'], equals('this is a string value in data column'));
      expect(row.data['name'], equals('Test Row'));
      expect(row.data['value'], equals(42));
      expect(row.data['\$id'], equals('row123'));

      // Verify that the main fields are assigned correctly
      expect(row.$id, equals('row123'));
      expect(row.$sequence, equals(1));
    });

    // Additional test to verify behavior when there's no data column
    test('fromMap should work correctly when map does not contain data column',
        () {
      final map = {
        '\$id': 'row456',
        '\$sequence': 2,
        '\$tableId': 'table1',
        '\$databaseId': 'db1',
        '\$createdAt': '2023-01-01T00:00:00.000Z',
        '\$updatedAt': '2023-01-01T00:00:00.000Z',
        '\$permissions': ['read'],
        'name': 'Another Row',
        'value': 100,
        // No data column - this should work fine
      };

      final row = Row.fromMap(map);

      expect(row.data, isA<Map<String, dynamic>>());
      expect(row.data['name'], equals('Another Row'));
      expect(row.data['value'], equals(100));
      expect(row.$id, equals('row456'));
    });
  });
}
