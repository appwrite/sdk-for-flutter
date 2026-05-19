import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PresenceList', () {
    test('model', () {
      final model = PresenceList(
        total: 5,
        presences: [],
      );

      final map = model.toMap();
      final result = PresenceList.fromMap(map);

      expect(result.total, 5);
      expect(result.presences, []);
    });
  });
}
