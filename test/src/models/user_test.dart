import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {

    test('model', () {
      final model = User(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        name: 'John Doe',
        registration: '2020-10-15T06:38:00.000+00:00',
        status: true,
        labels: [],
        passwordUpdate: '2020-10-15T06:38:00.000+00:00',
        email: 'john@appwrite.io',
        phone: '+4930901820',
        emailVerification: true,
        phoneVerification: true,
        prefs: Preferences(data: {}),
        accessedAt: '2020-10-15T06:38:00.000+00:00',
      );

      final map = model.toMap();
      final result = User.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.name, 'John Doe');
      expect(result.registration, '2020-10-15T06:38:00.000+00:00');
      expect(result.status, true);
      expect(result.labels, []);
      expect(result.passwordUpdate, '2020-10-15T06:38:00.000+00:00');
      expect(result.email, 'john@appwrite.io');
      expect(result.phone, '+4930901820');
      expect(result.emailVerification, true);
      expect(result.phoneVerification, true);
      expect(result.prefs.data, {"data": {}});
      expect(result.accessedAt, '2020-10-15T06:38:00.000+00:00');
    });
  });
}
