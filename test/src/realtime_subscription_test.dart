import 'package:appwrite/src/realtime_message.dart';
import 'package:appwrite/src/realtime_subscription.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:async';

void main() {
  group('RealtimeSubscription', () {
    final mockStream = StreamController<RealtimeMessage>.broadcast();
    final mockCloseFunction = () async {};
    final subscription = RealtimeSubscription(
        controller: mockStream,
        close: mockCloseFunction,
        channels: ['documents']);

    test('should have the correct stream and close function', () {
      expect(subscription.controller, equals(mockStream));
      expect(subscription.stream, equals(mockStream.stream));
      expect(subscription.close, equals(mockCloseFunction));
    });
  });
}
