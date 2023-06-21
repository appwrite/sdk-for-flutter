import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appwrite/src/realtime_response_connected.dart';

void main() {
  group('RealtimeResponseConnected', () {
    final channels = ['channel1', 'channel2'];
    final user = {'id': 123, 'name': 'John Doe'};
    final response1 = RealtimeResponseConnected(channels: channels, user: user);

    test('copyWith should create a new instance with updated properties', () {
      final newChannels = ['channel3', 'channel4'];
      final newUser = {'id': 456, 'name': 'Jane Smith'};

      final updatedResponse = response1.copyWith(channels: newChannels, user: newUser);

      expect(updatedResponse.channels, equals(newChannels));
      expect(updatedResponse.user, equals(newUser));
    });

    test('toMap should return a map representation of the response', () {
      final responseMap = response1.toMap();

      expect(responseMap['channels'], equals(channels));
      expect(responseMap['user'], equals(user));
    });

    test('fromMap should create an instance from a map', () {
      final responseMap = {'channels': channels, 'user': user};

      final response2 = RealtimeResponseConnected.fromMap(responseMap);

      expect(response2.channels, equals(channels));
      expect(response2.user, equals(user));
    });

    test('toJson and fromJson should convert to/from JSON', () {
      final jsonString = response1.toJson();

      final response3 = RealtimeResponseConnected.fromJson(jsonString);

      expect(response3.channels, equals(channels));
      expect(response3.user, equals(user));
    });

    test('toString should return a string representation of the response', () {
      final responseString = response1.toString();

      expect(responseString, equals('RealtimeResponseConnected(channels: $channels, user: $user)'));
    });

    test('equality operator should compare two instances', () {
      final response2 = RealtimeResponseConnected(channels: channels, user: user);

      expect(response1 == response2, isTrue);
    });

    test('hashCode should return a unique hash value', () {
      final hashCode1 = response1.hashCode;

      final response2 = RealtimeResponseConnected(channels: channels, user: user);
      final hashCode2 = response2.hashCode;

      expect(hashCode1, equals(hashCode2));
    });
  });
}
