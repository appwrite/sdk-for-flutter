import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirebaseProject', () {

    test('model', () {
      final model = FirebaseProject(
        projectId: 'my-project',
        displayName: 'My Project',
      );

      final map = model.toMap();
      final result = FirebaseProject.fromMap(map);

      expect(result.projectId, 'my-project');
      expect(result.displayName, 'My Project');
    });
  });
}
