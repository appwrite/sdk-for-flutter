import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Branch', () {

    test('model', () {
      final model = Branch(
        name: 'main',
      );

      final map = model.toMap();
      final result = Branch.fromMap(map);

      expect(result.name, 'main');
    });
  });
}
