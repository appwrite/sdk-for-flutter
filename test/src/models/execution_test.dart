import 'package:appwrite/models.dart';
import 'package:appwrite/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Execution', () {
    test('model', () {
      final model = Execution(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        $permissions: [],
        functionId: '5e5ea6g16897e',
        deploymentId: '5e5ea5c16897e',
        trigger: ExecutionTrigger.http,
        status: ExecutionStatus.waiting,
        requestMethod: 'GET',
        requestPath: '/articles?id=5',
        requestHeaders: [],
        responseStatusCode: 200,
        responseBody: '',
        responseHeaders: [],
        logs: '',
        errors: '',
        duration: 0.4,
      );

      final map = model.toMap();
      final result = Execution.fromMap(map);

            expect(result.$id, '5e5ea5c16897e');
                  expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$permissions, []);
                  expect(result.functionId, '5e5ea6g16897e');
                  expect(result.deploymentId, '5e5ea5c16897e');
                  expect(result.trigger, ExecutionTrigger.http);
                  expect(result.status, ExecutionStatus.waiting);
                  expect(result.requestMethod, 'GET');
                  expect(result.requestPath, '/articles?id=5');
                  expect(result.requestHeaders, []);
                  expect(result.responseStatusCode, 200);
                  expect(result.responseBody, '');
                  expect(result.responseHeaders, []);
                  expect(result.logs, '');
                  expect(result.errors, '');
                  expect(result.duration, 0.4);
          });
  });
}
