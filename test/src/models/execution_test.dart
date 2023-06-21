import 'package:appwrite/models.dart';
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
        trigger: 'http',
        status: 'processing',
        statusCode: 0,
        response: '',
        stdout: '',
        stderr: '',
        duration: 0.4,
      );

      final map = model.toMap();
      final result = Execution.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$permissions, []);
      expect(result.functionId, '5e5ea6g16897e');
      expect(result.trigger, 'http');
      expect(result.status, 'processing');
      expect(result.statusCode, 0);
      expect(result.response, '');
      expect(result.stdout, '');
      expect(result.stderr, '');
      expect(result.duration, 0.4);
    });
  });
}
