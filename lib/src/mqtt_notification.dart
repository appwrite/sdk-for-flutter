import 'dart:convert';

import 'mqtt_message.dart';

/// What a message asks a background notification to show. A payload that is not a JSON object
/// is [raw] and shown as it was sent; an envelope without a title or body shows nothing.
class PushNotificationContent {
  /// Whether the payload is not a JSON object, so it carries no envelope to read.
  final bool raw;
  final String? title;
  final String? body;
  final String? image;

  const PushNotificationContent._(this.raw, this.title, this.body, this.image);

  factory PushNotificationContent.of(PushMessage message) {
    Object? json;
    try {
      json = jsonDecode(message.data);
    } catch (_) {
      json = null;
    }
    if (json is! Map) {
      return const PushNotificationContent._(true, null, null, null);
    }
    final notification = json['notification'];
    String? field(String name) {
      final value = notification is Map ? notification[name] : null;
      return value is String && value.isNotEmpty ? value : null;
    }

    return PushNotificationContent._(
      false,
      field('title'),
      field('body'),
      field('image'),
    );
  }

  /// Whether to post a notification at all: data-only envelopes reach callbacks only.
  bool get visible => raw || title != null || body != null;

  /// The title to show: the server's, else [fallback].
  String titleOr(String fallback) => title ?? fallback;

  /// The body to show: the server's, else the payload itself when it is [raw].
  String? bodyFor(PushMessage message) => body ?? (raw ? message.data : null);
}
