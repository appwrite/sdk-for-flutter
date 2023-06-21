import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Membership', () {

    test('model', () {
      final model = Membership(
        $id: '5e5ea5c16897e',
        userId: '5e5ea5c16897e',
        teamId: '5e5ea5c16897e',
        name: 'VIP',
        email: 'john@appwrite.io',
        invited: 1592981250,
        joined: 1592981250,
        confirm: true,
        roles: [],
      );

      final map = model.toMap();
      final result = Membership.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.userId, '5e5ea5c16897e');
      expect(result.teamId, '5e5ea5c16897e');
      expect(result.name, 'VIP');
      expect(result.email, 'john@appwrite.io');
      expect(result.invited, 1592981250);
      expect(result.joined, 1592981250);
      expect(result.confirm, true);
      expect(result.roles, []);
    });
  });
}
