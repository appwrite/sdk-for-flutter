import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Realtime Message
class RealtimeMessage {
  /// All permutations of the system event that triggered this message
  ///
  /// The first event in the list is the most specfic event without wildcards.
  final List<String> events;

  /// The data related to the event
  final Map<String, dynamic> payload;

  /// All channels that match this event
  final List<String> channels;

  /// ISO 8601 formatted timestamp in UTC timezone in
  /// which the event was sent from Appwrite
  final String timestamp;

  /// Initializes a [RealtimeMessage]
  RealtimeMessage({
    required this.events,
    required this.payload,
    required this.channels,
    required this.timestamp,
  });

  /// Returns a copy of this [RealtimeMessage] with specified attributes overridden.
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

  /// Returns a [Map<String, dynamic>] representation of this [RealtimeMessage].
  Map<String, dynamic> toMap() {
    return {
      'events': events,
      'payload': payload,
      'channels': channels,
      'timestamp': timestamp,
    };
  }

  /// Initializes a [RealtimeMessage] from a [Map<String, dynamic>].
  factory RealtimeMessage.fromMap(Map<String, dynamic> map) {
    return RealtimeMessage(
      events: List<String>.from(map['events'] ?? []),
      payload: Map<String, dynamic>.from(map['payload'] ?? <String, dynamic>{}),
      channels: List<String>.from(map['channels'] ?? []),
      timestamp: map['timestamp'],
    );
  }

  /// Converts a [RealtimeMessage] to a JSON [String].
  String toJson() => json.encode(toMap());

  /// Initializes a [RealtimeMessage] from a JSON [String].
  factory RealtimeMessage.fromJson(String source) =>
      RealtimeMessage.fromMap(json.decode(source));

  /// Returns a string representation of this [RealtimeMessage].
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
