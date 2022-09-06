import 'dart:convert';
import 'package:flutter/foundation.dart';

class RealtimeMessage {
  final List<String> events;
  final Map<String, dynamic> payload;
  final List<String> channels;
  final String timestamp;
  RealtimeMessage({
    required this.events,
    required this.payload,
    required this.channels,
    required this.timestamp,
  });

  RealtimeMessage copyWith({
    List<String>? events,
    Map<String, dynamic>? payload,
    List<String>? channels,
    String? timestamp,
  }) {
    return RealtimeMessage(
      events: events ?? this.events,
      payload: payload ?? this.payload,
      channels: channels ?? this.channels,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'events': events,
      'payload': payload,
      'channels': channels,
      'timestamp': timestamp,
    };
  }

  factory RealtimeMessage.fromMap(Map<String, dynamic> map) {
    return RealtimeMessage(
      events: List<String>.from(map['events'] ?? []),
      payload: Map<String, dynamic>.from(map['payload'] ?? <String, dynamic>{}),
      channels: List<String>.from(map['channels'] ?? []),
      timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RealtimeMessage.fromJson(String source) =>
      RealtimeMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RealtimeMessage(events: $events, payload: $payload, channels: $channels, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RealtimeMessage &&
        listEquals(other.events, events) &&
        mapEquals(other.payload, payload) &&
        listEquals(other.channels, channels) &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return events.hashCode ^
        payload.hashCode ^
        channels.hashCode ^
        timestamp.hashCode;
  }
}
