import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AlgoSha', () {

    test('model', () {
      final model = AlgoSha(
        type: 'sha',
      );

      final map = model.toMap();
      final result = AlgoSha.fromMap(map);

      expect(result.type, 'sha');
    });
  });
}
