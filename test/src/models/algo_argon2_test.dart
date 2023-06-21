import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AlgoArgon2', () {

    test('model', () {
      final model = AlgoArgon2(
        type: 'argon2',
        memoryCost: 65536,
        timeCost: 4,
        threads: 3,
      );

      final map = model.toMap();
      final result = AlgoArgon2.fromMap(map);

      expect(result.type, 'argon2');
      expect(result.memoryCost, 65536);
      expect(result.timeCost, 4);
      expect(result.threads, 3);
    });
  });
}
