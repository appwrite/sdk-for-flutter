import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TeamList', () {

    test('model', () {
      final model = TeamList(
        total: 5,
        teams: [],
      );

      final map = model.toMap();
      final result = TeamList.fromMap(map);

      expect(result.total, 5);
      expect(result.teams, []);
    });
  });
}
