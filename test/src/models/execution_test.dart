import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Execution', () {

    test('model', () {
      final model = Execution(
        $id: '5e5ea5c16897e',
        $read: [],
        functionId: '5e5ea6g16897e',
        dateCreated: 1592981250,
        trigger: 'http',
        status: 'processing',
        statusCode: 0,
        stdout: '',
        stderr: '',
        time: 0.4,
      );

      final map = model.toMap();
      final result = Execution.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$read, []);
      expect(result.functionId, '5e5ea6g16897e');
      expect(result.dateCreated, 1592981250);
      expect(result.trigger, 'http');
      expect(result.status, 'processing');
      expect(result.statusCode, 0);
      expect(result.stdout, '');
      expect(result.stderr, '');
      expect(result.time, 0.4);
    });
  });
}
