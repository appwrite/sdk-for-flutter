import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppsList', () {
    test('model', () {
      final model = AppsList(
        total: 5,
        apps: [],
      );

      final map = model.toMap();
      final result = AppsList.fromMap(map);

            expect(result.total, 5);
                  expect(result.apps, []);
          });
  });
}
