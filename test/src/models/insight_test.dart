import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Insight', () {
    test('model', () {
      final model = Insight(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        reportId: '5e5ea5c16897e',
        type: 'tablesDBIndex',
        severity: 'warning',
        status: 'active',
        resourceType: 'databases',
        resourceId: 'main',
        parentResourceType: 'tables',
        parentResourceId: 'orders',
        title: 'Missing index on collection orders',
        summary: 'Queries against `orders.status` are scanning the full collection.',
        ctas: [],
      );

      final map = model.toMap();
      final result = Insight.fromMap(map);

            expect(result.$id, '5e5ea5c16897e');
                  expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.reportId, '5e5ea5c16897e');
                  expect(result.type, 'tablesDBIndex');
                  expect(result.severity, 'warning');
                  expect(result.status, 'active');
                  expect(result.resourceType, 'databases');
                  expect(result.resourceId, 'main');
                  expect(result.parentResourceType, 'tables');
                  expect(result.parentResourceId, 'orders');
                  expect(result.title, 'Missing index on collection orders');
                  expect(result.summary, 'Queries against `orders.status` are scanning the full collection.');
                  expect(result.ctas, []);
          });
  });
}
