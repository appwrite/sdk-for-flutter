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
    });
  });

  group('any()', () {
    test('appends a single-level wildcard', () {
      expect(
        Topic.path(['user']).any().path(['notification']).toString(),
        'user/+/notification',
      );
      expect(
        Topic.path(['chat']).any().any().path(['message']).toString(),
        'chat/+/+/message',
      );
    });

    test('starts a topic', () {
      expect(Topic.any().path(['notification']).toString(), '+/notification');
    });
  });

  group('all()', () {
    test('ends a topic', () {
      expect(
        Topic.path(['org']).any().path(['logs']).all().toString(),
        'org/+/logs/#',
      );
    });

    test('matches every topic', () {
      expect(Topic.all().toString(), '#');
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
        expect(() => Topic.any().path(levels), throwsArgumentError);
      });
    });
  });
}
