import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2ConsentTokenList', () {
    test('model', () {
      final model = Oauth2ConsentTokenList(
        total: 5,
        tokens: [],
      );

      final map = model.toMap();
      final result = Oauth2ConsentTokenList.fromMap(map);

      expect(result.total, 5);
      expect(result.tokens, []);
    });
  });
}
