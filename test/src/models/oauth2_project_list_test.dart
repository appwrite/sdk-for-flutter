import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2ProjectList', () {
    test('model', () {
      final model = Oauth2ProjectList(
        total: 5,
        projects: [],
      );

      final map = model.toMap();
      final result = Oauth2ProjectList.fromMap(map);

      expect(result.total, 5);
      expect(result.projects, []);
    });
  });
}
