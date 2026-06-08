import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSecret', () {
    test('model', () {
      final model = AppSecret(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        appId: '5e5ea5c16897e',
        secret: '\$argon2i\$v=19\$m=16,t=2,p=1\$MTIzMTIzMTIzMTIzMQ\$3/ZUl3IWERBO2RIm5rHltg',
        hint: 'f5c6c7',
        createdById: '5e5ea5c16897e',
        createdByName: 'Walter White',
      );

      final map = model.toMap();
      final result = AppSecret.fromMap(map);

            expect(result.$id, '5e5ea5c16897e');
                  expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.appId, '5e5ea5c16897e');
                  expect(result.secret, '\$argon2i\$v=19\$m=16,t=2,p=1\$MTIzMTIzMTIzMTIzMQ\$3/ZUl3IWERBO2RIm5rHltg');
                  expect(result.hint, 'f5c6c7');
                  expect(result.createdById, '5e5ea5c16897e');
                  expect(result.createdByName, 'Walter White');
          });
  });
}
