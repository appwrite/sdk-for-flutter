import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Device', () {
    test('model', () {
      final model = Device(
        $id: "5e5ea5c16897e",
        $createdAt: "2020-10-15T06:38:00.000+00:00",
        $updatedAt: "2020-10-15T06:38:00.000+00:00",
        expire: "2020-10-15T06:38:00.000+00:00",
        activeSessionId: "5e5bb8c16897e",
        sessions: [],
        secret: "5e5bb8c16897e",
      );

      final map = model.toMap();
      final result = Device.fromMap(map);

      expect(result.$id, "5e5ea5c16897e");
      expect(result.$createdAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.$updatedAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.expire, "2020-10-15T06:38:00.000+00:00");
      expect(result.activeSessionId, "5e5bb8c16897e");
      expect(result.sessions, []);
      expect(result.secret, "5e5bb8c16897e");
    });
  });
}
