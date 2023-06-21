import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Team', () {

    test('model', () {
      final model = Team(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        name: 'VIP',
        total: 7,
        prefs: Preferences(data: {}),
      );

      final map = model.toMap();
      final result = Team.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.name, 'VIP');
      expect(result.total, 7);
      expect(result.prefs.data, {"data": {}});
    });
  });
}
