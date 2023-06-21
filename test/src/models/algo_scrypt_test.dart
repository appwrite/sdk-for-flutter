import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AlgoScrypt', () {

    test('model', () {
      final model = AlgoScrypt(
        type: 'scrypt',
        costCpu: 8,
        costMemory: 14,
        costParallel: 1,
        length: 64,
      );

      final map = model.toMap();
      final result = AlgoScrypt.fromMap(map);

      expect(result.type, 'scrypt');
      expect(result.costCpu, 8);
      expect(result.costMemory, 14);
      expect(result.costParallel, 1);
      expect(result.length, 64);
    });
  });
}
