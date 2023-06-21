import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SessionList', () {

    test('model', () {
      final model = SessionList(
        total: 5,
        sessions: [],
      );

      final map = model.toMap();
      final result = SessionList.fromMap(map);

      expect(result.total, 5);
      expect(result.sessions, []);
    });
  });
}
