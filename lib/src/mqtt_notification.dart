import 'dart:convert';

import 'mqtt_message.dart';

/// What a message's `notification` block asks a background notification to show: nulls when
/// the payload has none or is not JSON.
class PushNotificationContent {
  /// Whether the message has a `notification` block at all.
  final bool present;
  final String? title;
  final String? body;
  final String? image;

  const PushNotificationContent._(
    this.present,
    this.title,
    this.body,
    this.image,
  );

  factory PushNotificationContent.of(PushMessage message) {
    Object? notification;
    try {
      final json = jsonDecode(message.data);
      notification = json is Map ? json['notification'] : null;
    } catch (_) {
      notification = null;
    }
    String? field(String name) {
      final value = notification is Map ? notification[name] : null;
      return value is String && value.isNotEmpty ? value : null;
    }

    return PushNotificationContent._(
      notification is Map,
      field('title'),
      field('body'),
      field('image'),
    );
  }

  /// The title to show: the server's, else [fallback].
  String titleOr(String fallback) => title ?? fallback;

  /// The body to show: the server's, else the raw payload when the message carries no
  /// notification block at all.
  String? bodyFor(PushMessage message) =>
      body ?? (present ? null : message.data);
}
