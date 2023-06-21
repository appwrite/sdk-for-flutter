import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Team', () {

    test('model', () {
      final model = Team(
        $id: '5e5ea5c16897e',
        name: 'VIP',
        dateCreated: 1592981250,
        total: 7,
      );

      final map = model.toMap();
      final result = Team.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.name, 'VIP');
      expect(result.dateCreated, 1592981250);
      expect(result.total, 7);
    });
  });
}
