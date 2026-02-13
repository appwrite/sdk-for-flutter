import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Key', () {
    test('model', () {
      final model = Key(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        name: 'My API Key',
        expire: '2020-10-15T06:38:00.000+00:00',
        scopes: [],
        secret: '919c2d18fb5d4...a2ae413da83346ad2',
        accessedAt: '2020-10-15T06:38:00.000+00:00',
        sdks: [],
      );

      final map = model.toMap();
      final result = Key.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.name, 'My API Key');
      expect(result.expire, '2020-10-15T06:38:00.000+00:00');
      expect(result.scopes, []);
      expect(result.secret, '919c2d18fb5d4...a2ae413da83346ad2');
      expect(result.accessedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.sdks, []);
    });
  });
}
