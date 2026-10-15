import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('path()', () {
    test('joins levels', () {
      expect(Topic.path(['user']).toString(), 'user');
      expect(
        Topic.path(['user', 'notification']).toString(),
        'user/notification',
      );
    });

    test('appends levels', () {
      expect(
        Topic.path(['user']).path(['notification']).toString(),
        'user/notification',
      );
      expect(
        Topic.path(['org', '42']).path(['logs']).toString(),
        'org/42/logs',
      );
    });
  });

  group('errors', () {
    final invalid = <String, List<String>>{
      'an empty path': [],
      'an empty level': ['user', ''],
      'a slash': ['user/123'],
      'a lone +': ['user', '+'],
      'an embedded +': ['user', 'a+b'],
      'a lone #': ['user', '#'],
      'an embedded #': ['user', 'a#b'],
    };

    invalid.forEach((name, levels) {
      test('rejects $name', () {
        expect(() => Topic.path(levels), throwsArgumentError);
        expect(() => Topic.path(['user']).path(levels), throwsArgumentError);
      });
    });
  });
}
