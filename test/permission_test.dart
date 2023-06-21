import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('read()', () {
    test('returns read', () {
      expect(Permission.read(Role.any()), 'read("any")');
    });
  });

  group('write()', () {
    test('returns write', () {
      expect(Permission.write(Role.any()), 'write("any")');
    });
  });

  group('create()', () {
    test('returns create', () {
      expect(Permission.create(Role.any()), 'create("any")');
    });
  });

  group('update()', () {
    test('returns update', () {
      expect(Permission.update(Role.any()), 'update("any")');
    });
  });

  group('delete()', () {
    test('returns delete', () {
      expect(Permission.delete(Role.any()), 'delete("any")');
    });
  });
}
