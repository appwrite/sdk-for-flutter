import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirebaseProjectList', () {

    test('model', () {
      final model = FirebaseProjectList(
        total: 5,
        projects: [],
      );

      final map = model.toMap();
      final result = FirebaseProjectList.fromMap(map);

      expect(result.total, 5);
      expect(result.projects, []);
    });
  });
}
