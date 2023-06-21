import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExecutionList', () {

    test('model', () {
      final model = ExecutionList(
        total: 5,
        executions: [],
      );

      final map = model.toMap();
      final result = ExecutionList.fromMap(map);

      expect(result.total, 5);
      expect(result.executions, []);
    });
  });
}
