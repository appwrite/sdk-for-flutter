import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appwrite/src/realtime_response.dart';

void main() {
  group('RealtimeResponse', () {
    final type = 'event';
    final data = {'event': 'message', 'payload': 'Hello, world!'};
    final response1 = RealtimeResponse(type: type, data: data);

    test('copyWith should create a new instance with updated properties', () {
      final newType = 'response';
      final newData = {'result': true};

      final updatedResponse = response1.copyWith(type: newType, data: newData);

      expect(updatedResponse.type, equals(newType));
      expect(updatedResponse.data, equals(newData));
    });

    test('toMap should return a map representation of the response', () {
      final responseMap = response1.toMap();

      expect(responseMap['type'], equals(type));
      expect(responseMap['data'], equals(data));
    });

    test('fromMap should create an instance from a map', () {
      final responseMap = {'type': type, 'data': data};

      final response2 = RealtimeResponse.fromMap(responseMap);

      expect(response2.type, equals(type));
      expect(response2.data, equals(data));
    });

    test('toJson and fromJson should convert to/from JSON', () {
      final jsonString = response1.toJson();

      final response3 = RealtimeResponse.fromJson(jsonString);

      expect(response3.type, equals(type));
      expect(response3.data, equals(data));
    });

    test('toString should return a string representation of the response', () {
      final responseString = response1.toString();

      expect(
          responseString, equals('RealtimeResponse(type: $type, data: $data)'));
    });

    test('equality operator should compare two instances', () {
      final response2 = RealtimeResponse(type: type, data: data);

      expect(response1 == response2, isTrue);
    });

    test('hashCode should return a unique hash value', () {
      final hashCode1 = response1.hashCode;

      final response2 = RealtimeResponse(type: type, data: data);
      final hashCode2 = response2.hashCode;

      expect(hashCode1, equals(hashCode2));
    });
  });
}
