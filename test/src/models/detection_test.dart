import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Detection', () {

    test('model', () {
      final model = Detection(
        runtime: 'node',
      );

      final map = model.toMap();
      final result = Detection.fromMap(map);

      expect(result.runtime, 'node');
    });
  });
}
