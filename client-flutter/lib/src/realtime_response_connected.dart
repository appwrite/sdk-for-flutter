import 'dart:convert';
import 'package:flutter/foundation.dart';

class RealtimeResponseConnected {
  final List<String> channels;
  final Map<String, dynamic> user;
  RealtimeResponseConnected({
    required this.channels,
    this.user = const {},
  });

  RealtimeResponseConnected copyWith({
    List<String>? channels,
    Map<String, dynamic>? user,
  }) {
    return RealtimeResponseConnected(
      channels: channels ?? this.channels,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'channels': channels,
      'user': user,
    };
  }

  factory RealtimeResponseConnected.fromMap(Map<String, dynamic> map) {
    return RealtimeResponseConnected(
      channels: List<String>.from(map['channels']),
      user: Map<String, dynamic>.from(map['user'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory RealtimeResponseConnected.fromJson(String source) =>
      RealtimeResponseConnected.fromMap(json.decode(source));

  @override
  String toString() =>
      'RealtimeResponseConnected(channels: $channels, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RealtimeResponseConnected &&
        listEquals(other.channels, channels) &&
        mapEquals(other.user, user);
  }

  @override
  int get hashCode => channels.hashCode ^ user.hashCode;
}
