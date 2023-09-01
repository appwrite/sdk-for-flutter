import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('any()', () {
    test('returns any', () {
      expect(Role.any(), 'any');
    });
  });

  group('user()', () {
    test('without status', () {
      expect(Role.user('custom'), 'user:custom');
    });

    test('with status', () {
      expect(Role.user('custom', 'verified'), 'user:custom/verified');
    });
  });

  group('users()', () {
    test('without status', () {
      expect(Role.users(), 'users');
    });

    test('with status', () {
      expect(Role.users('verified'), 'users/verified');
    });
  });

  group('guests()', () {
    test('returns guests', () {
      expect(Role.guests(), 'guests');
    });
  });

  group('team()', () {
    test('without role', () {
      expect(Role.team('custom'), 'team:custom');
    });

    test('with role', () {
      expect(Role.team('custom', 'owner'), 'team:custom/owner');
    });
  });

  group('member()', () {
    test('returns member', () {
      expect(Role.member('custom'), 'member:custom');
    });
  });

  group('label()', () {
    test('returns label', () {
      expect(Role.label('admin'), 'label:admin');
    });
  });
}
