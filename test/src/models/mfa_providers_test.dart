import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MfaProviders', () {

    test('model', () {
      final model = MfaProviders(
        totp: true,
        phone: true,
        email: true,
      );

      final map = model.toMap();
      final result = MfaProviders.fromMap(map);

      expect(result.totp, true);
      expect(result.phone, true);
      expect(result.email, true);
    });
  });
}
