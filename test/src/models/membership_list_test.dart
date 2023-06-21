import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MembershipList', () {

    test('model', () {
      final model = MembershipList(
        total: 5,
        memberships: [],
      );

      final map = model.toMap();
      final result = MembershipList.fromMap(map);

      expect(result.total, 5);
      expect(result.memberships, []);
    });
  });
}
