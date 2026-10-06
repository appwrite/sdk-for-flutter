import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2Organization', () {
    test('model', () {
      final model = Oauth2Organization(
        $id: "5e5ea5c16897e",
      );

      final map = model.toMap();
      final result = Oauth2Organization.fromMap(map);

      expect(result.$id, "5e5ea5c16897e");
    });
  });
}
