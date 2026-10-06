import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Oauth2Project', () {
    test('model', () {
      final model = Oauth2Project(
        $id: "5e5ea5c16897e",
        region: "fra",
        endpoint: "https://fra.cloud.appwrite.io/v1",
      );

      final map = model.toMap();
      final result = Oauth2Project.fromMap(map);

      expect(result.$id, "5e5ea5c16897e");
      expect(result.region, "fra");
      expect(result.endpoint, "https://fra.cloud.appwrite.io/v1");
    });
  });
}
