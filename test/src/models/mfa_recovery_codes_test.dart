import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MfaRecoveryCodes', () {
    test('model', () {
      final model = MfaRecoveryCodes(
        recoveryCodes: [],
      );

      final map = model.toMap();
      final result = MfaRecoveryCodes.fromMap(map);

      expect(result.recoveryCodes, []);
    });
  });
}
