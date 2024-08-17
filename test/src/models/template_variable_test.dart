import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TemplateVariable', () {

    test('model', () {
      final model = TemplateVariable(
        name: 'APPWRITE_DATABASE_ID',
        description: 'The ID of the Appwrite database that contains the collection to sync.',
        value: '512',
        placeholder: '64a55...7b912',
        xrequired: true,
        type: 'password',
      );

      final map = model.toMap();
      final result = TemplateVariable.fromMap(map);

      expect(result.name, 'APPWRITE_DATABASE_ID');
      expect(result.description, 'The ID of the Appwrite database that contains the collection to sync.');
      expect(result.value, '512');
      expect(result.placeholder, '64a55...7b912');
      expect(result.xrequired, true);
      expect(result.type, 'password');
    });
  });
}
