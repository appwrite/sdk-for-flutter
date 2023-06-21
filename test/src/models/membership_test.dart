import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Membership', () {

    test('model', () {
      final model = Membership(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        userId: '5e5ea5c16897e',
        userName: 'John Doe',
        userEmail: 'john@appwrite.io',
        teamId: '5e5ea5c16897e',
        teamName: 'VIP',
        invited: '2020-10-15T06:38:00.000+00:00',
        joined: '2020-10-15T06:38:00.000+00:00',
        confirm: true,
        roles: [],
      );

      final map = model.toMap();
      final result = Membership.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.userId, '5e5ea5c16897e');
      expect(result.userName, 'John Doe');
      expect(result.userEmail, 'john@appwrite.io');
      expect(result.teamId, '5e5ea5c16897e');
      expect(result.teamName, 'VIP');
      expect(result.invited, '2020-10-15T06:38:00.000+00:00');
      expect(result.joined, '2020-10-15T06:38:00.000+00:00');
      expect(result.confirm, true);
      expect(result.roles, []);
    });
  });
}
