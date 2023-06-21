import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Token', () {

    test('model', () {
      final model = Token(
        $id: 'bb8ea5c16897e',
        userId: '5e5ea5c168bb8',
        secret: '',
        expire: 1592981250,
      );

      final map = model.toMap();
      final result = Token.fromMap(map);

      expect(result.$id, 'bb8ea5c16897e');
      expect(result.userId, '5e5ea5c168bb8');
      expect(result.secret, '');
      expect(result.expire, 1592981250);
    });
  });
}
