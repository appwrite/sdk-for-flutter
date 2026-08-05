import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2ConsentList', () {
    test('model', () {
      final model = Oauth2ConsentList(
        total: 5,
        consents: [],
      );

      final map = model.toMap();
      final result = Oauth2ConsentList.fromMap(map);

            expect(result.total, 5);
                  expect(result.consents, []);
          });
  });
}
