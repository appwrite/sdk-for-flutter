import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MfaFactors', () {

    test('model', () {
      final model = MfaFactors(
        totp: true,
        phone: true,
        email: true,
        recoveryCode: true,
      );

      final map = model.toMap();
      final result = MfaFactors.fromMap(map);

      expect(result.totp, true);
      expect(result.phone, true);
      expect(result.email, true);
      expect(result.recoveryCode, true);
    });
  });
}
