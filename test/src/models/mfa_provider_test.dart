import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MfaProvider', () {

    test('model', () {
      final model = MfaProvider(
        backups: [],
        secret: '1',
        uri: '1',
      );

      final map = model.toMap();
      final result = MfaProvider.fromMap(map);

      expect(result.backups, []);
      expect(result.secret, '1');
      expect(result.uri, '1');
    });
  });
}
