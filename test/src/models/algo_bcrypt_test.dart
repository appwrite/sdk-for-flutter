import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AlgoBcrypt', () {

    test('model', () {
      final model = AlgoBcrypt(
        type: 'bcrypt',
      );

      final map = model.toMap();
      final result = AlgoBcrypt.fromMap(map);

      expect(result.type, 'bcrypt');
    });
  });
}
