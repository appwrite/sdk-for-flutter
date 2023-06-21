import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AlgoMd5', () {

    test('model', () {
      final model = AlgoMd5(
        type: 'md5',
      );

      final map = model.toMap();
      final result = AlgoMd5.fromMap(map);

      expect(result.type, 'md5');
    });
  });
}
