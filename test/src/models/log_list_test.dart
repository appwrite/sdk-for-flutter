import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogList', () {

    test('model', () {
      final model = LogList(
        total: 5,
        logs: [],
      );

      final map = model.toMap();
      final result = LogList.fromMap(map);

      expect(result.total, 5);
      expect(result.logs, []);
    });
  });
}
