import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Target', () {

    test('model', () {
      final model = Target(
        $id: '259125845563242502',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        name: 'Apple iPhone 12',
        userId: '259125845563242502',
        providerType: 'email',
        identifier: 'token',
        expired: true,
      );

      final map = model.toMap();
      final result = Target.fromMap(map);

      expect(result.$id, '259125845563242502');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.name, 'Apple iPhone 12');
      expect(result.userId, '259125845563242502');
      expect(result.providerType, 'email');
      expect(result.identifier, 'token');
      expect(result.expired, true);
    });
  });
}
