import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UsageResources', () {
    test('model', () {
      final model = UsageResources(
        name: '',
        value: 0,
        amount: 500,
        rate: 12.5,
        desc: 'Your monthly recurring Pro plan.',
        resourceId: '',
      );

      final map = model.toMap();
      final result = UsageResources.fromMap(map);

            expect(result.name, '');
                  expect(result.value, 0);
                  expect(result.amount, 500);
                  expect(result.rate, 12.5);
                  expect(result.desc, 'Your monthly recurring Pro plan.');
                  expect(result.resourceId, '');
          });
  });
}
