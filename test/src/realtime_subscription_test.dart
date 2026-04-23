import 'package:appwrite/src/realtime_message.dart';
import 'package:appwrite/src/realtime_subscription.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:async';

void main() {
  group('RealtimeSubscription', () {
    final mockStream = StreamController<RealtimeMessage>.broadcast();
    final mockCloseFunction = () async {};
    final mockUnsubscribeFunction = () async {};
    Future<void> mockUpdateFunction(
        {List<Object>? channels, List<String>? queries}) async {}
    final subscription = RealtimeSubscription(
        controller: mockStream,
        close: mockCloseFunction,
        unsubscribe: mockUnsubscribeFunction,
        update: mockUpdateFunction,
        channels: ['documents'],
        queries: const []);

    test('should have the correct stream and close function', () {
      expect(subscription.controller, equals(mockStream));
      expect(subscription.stream, equals(mockStream.stream));
      expect(subscription.close, equals(mockCloseFunction));
      expect(subscription.unsubscribe, equals(mockUnsubscribeFunction));
      expect(subscription.update, equals(mockUpdateFunction));
    });
  });
}
