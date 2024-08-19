import 'dart:convert';
import 'package:flutter/foundation.dart';

class RealtimeResponse {
  final String type; // error, event, connected, response
  final Map<String, dynamic> data;
  RealtimeResponse({
    required this.type,
    required this.data,
  });

  RealtimeResponse copyWith({
    String? type,
    Map<String, dynamic>? data,
  }) {
    return RealtimeResponse(
      type: type ?? this.type,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'data': data,
    };
  }

  factory RealtimeResponse.fromMap(Map<String, dynamic> map) {
    return RealtimeResponse(
      type: map['type'],
      data: Map<String, dynamic>.from(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RealtimeResponse.fromJson(String source) =>
      RealtimeResponse.fromMap(json.decode(source));

  @override
  String toString() => 'RealtimeResponse(type: $type, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RealtimeResponse &&
        other.type == type &&
        mapEquals(other.data, data);
  }

  @override
  int get hashCode => type.hashCode ^ data.hashCode;
}
