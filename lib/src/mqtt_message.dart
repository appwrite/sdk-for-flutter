import 'dart:convert';
import 'dart:typed_data';

/// A message delivered on a subscribed topic — the MQTT push analog of a
/// realtime event.
class PushMessage {
  /// The topic the message was published to.
  final String topic;

  /// The raw message payload.
  final Uint8List payload;

  /// The MQTT quality of service the message was delivered with.
  final int qos;

  const PushMessage({
    required this.topic,
    required this.payload,
    required this.qos,
  });

  /// The payload decoded as UTF-8 text, as it was sent.
  String get data => utf8.decode(payload);
}
