import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppScope', () {
    test('model', () {
      final model = AppScope(
        value: "organization:organization.read",
        description: "Access to read the organization",
        type: "organization",
        category: "Organization",
        deprecated: true,
      );

      final map = model.toMap();
      final result = AppScope.fromMap(map);

      expect(result.value, "organization:organization.read");
      expect(result.description, "Access to read the organization");
      expect(result.type, "organization");
      expect(result.category, "Organization");
      expect(result.deprecated, true);
    });
  });
}
