import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DowngradeFeedback', () {
    test('model', () {
      final model = DowngradeFeedback(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        title: 'I encountered a bug and outage that caused my app to lose its value',
        message: 'The platform experienced significant downtime which affected my users.',
        fromPlanId: 'pro',
        toPlanId: 'free',
        teamId: '5e5ea5c16897e',
        userId: '5e5ea5c16897e',
        version: '1.8.0',
      );

      final map = model.toMap();
      final result = DowngradeFeedback.fromMap(map);

            expect(result.$id, '5e5ea5c16897e');
                  expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.title, 'I encountered a bug and outage that caused my app to lose its value');
                  expect(result.message, 'The platform experienced significant downtime which affected my users.');
                  expect(result.fromPlanId, 'pro');
                  expect(result.toPlanId, 'free');
                  expect(result.teamId, '5e5ea5c16897e');
                  expect(result.userId, '5e5ea5c16897e');
                  expect(result.version, '1.8.0');
          });
  });
}
