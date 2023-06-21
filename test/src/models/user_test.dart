import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {

    test('model', () {
      final model = User(
        $id: '5e5ea5c16897e',
        name: 'John Doe',
        registration: 1592981250,
        status: true,
        passwordUpdate: 1592981250,
        email: 'john@appwrite.io',
        emailVerification: true,
        prefs: Preferences(data: {}),
      );

      final map = model.toMap();
      final result = User.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.name, 'John Doe');
      expect(result.registration, 1592981250);
      expect(result.status, true);
      expect(result.passwordUpdate, 1592981250);
      expect(result.email, 'john@appwrite.io');
      expect(result.emailVerification, true);
      expect(result.prefs.data, {"data": {}});
    });
  });
}
