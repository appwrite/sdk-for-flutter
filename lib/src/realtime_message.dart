import 'dart:convert';
import 'package:flutter/foundation.dart';

class RealtimeMessage {
  final String event;
  final Map<String, dynamic> payload;
  final List<String> channels;
  final DateTime timestamp;
  RealtimeMessage({
    required this.event,
    required this.payload,
    required this.channels,
    required this.timestamp,
  });

  RealtimeMessage copyWith({
    String? event,
    Map<String, dynamic>? payload,
    List<String>? channels,
    DateTime? timestamp,
  }) {
    return RealtimeMessage(
      event: event ?? this.event,
      payload: payload ?? this.payload,
      channels: channels ?? this.channels,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'event': event,
      'payload': payload,
      'channels': channels,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory RealtimeMessage.fromMap(Map<String, dynamic> map) {
    return RealtimeMessage(
      event: map['event'],
      payload: Map<String, dynamic>.from(map['payload'] ?? <String, dynamic>{}),
      channels: List<String>.from(map['channels'] ?? []),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RealtimeMessage.fromJson(String source) =>
      RealtimeMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RealtimeMessage(event: $event, payload: $payload, channels: $channels, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RealtimeMessage &&
        other.event == event &&
        mapEquals(other.payload, payload) &&
        listEquals(other.channels, channels) &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return event.hashCode ^
        payload.hashCode ^
        channels.hashCode ^
        timestamp.hashCode;
  }
}
