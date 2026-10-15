import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:appwrite/src/mqtt_message.dart';
import 'package:appwrite/src/mqtt_notification.dart';

PushMessage pushMessage(String data) =>
    PushMessage(topic: 'users/user', payload: utf8.encode(data), qos: 1);

void main() {
  group('PushNotificationContent', () {
    final invisible = {
      'data-only envelope': {
        'messageId': 'data',
        'data': {'saleId': '42'},
        'priority': 'high',
      },
      'empty notification': {'notification': {}},
      'contentAvailable and badge only': {
        'notification': {'contentAvailable': true, 'badge': 3},
      },
      'image only': {
        'notification': {'image': 'https://example.com/image.png'},
      },
    };

    invisible.forEach((name, envelope) {
      test('$name shows no notification', () {
        final push = pushMessage(jsonEncode(envelope));
        final content = PushNotificationContent.of(push);

        expect(content.visible, isFalse);
        expect(content.bodyFor(push), isNull);
      });
    });

    test('server title and body show as sent', () {
      final push = pushMessage(
        jsonEncode({
          'notification': {'title': 'Sale', 'body': 'Half off'},
          'data': {'saleId': '42'},
        }),
      );
      final content = PushNotificationContent.of(push);

      expect(content.visible, isTrue);
      expect(content.titleOr('Fallback'), 'Sale');
      expect(content.bodyFor(push), 'Half off');
    });

    test('server body alone uses the fallback title', () {
      final push = pushMessage(
        jsonEncode({
          'notification': {'body': 'Half off'},
        }),
      );
      final content = PushNotificationContent.of(push);

      expect(content.visible, isTrue);
      expect(content.titleOr('Fallback'), 'Fallback');
      expect(content.bodyFor(push), 'Half off');
    });

    test('non-JSON payload shows the fallback title and raw body', () {
      final push = pushMessage('push-payload');
      final content = PushNotificationContent.of(push);

      expect(content.visible, isTrue);
      expect(content.titleOr('Fallback'), 'Fallback');
      expect(content.bodyFor(push), 'push-payload');
    });

    test('JSON that is not an object is shown raw', () {
      final push = pushMessage('[1, 2]');
      final content = PushNotificationContent.of(push);

      expect(content.visible, isTrue);
      expect(content.bodyFor(push), '[1, 2]');
    });
  });
}
