import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Report', () {
    test('model', () {
      final model = Report(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        appId: '5e5ea5c16897e',
        type: 'lighthouse',
        title: 'Lighthouse audit for https://appwrite.io/',
        summary: 'Performance score 78. 4 opportunities found.',
        targetType: 'urls',
        target: 'https://appwrite.io/',
        categories: [],
        insights: [],
      );

      final map = model.toMap();
      final result = Report.fromMap(map);

            expect(result.$id, '5e5ea5c16897e');
                  expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.appId, '5e5ea5c16897e');
                  expect(result.type, 'lighthouse');
                  expect(result.title, 'Lighthouse audit for https://appwrite.io/');
                  expect(result.summary, 'Performance score 78. 4 opportunities found.');
                  expect(result.targetType, 'urls');
                  expect(result.target, 'https://appwrite.io/');
                  expect(result.categories, []);
                  expect(result.insights, []);
          });
  });
}
