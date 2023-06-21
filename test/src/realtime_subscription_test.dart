import 'package:mockito/mockito.dart';
import 'package:appwrite/src/realtime_message.dart';
import 'package:appwrite/src/realtime_subscription.dart';
import 'package:flutter_test/flutter_test.dart';

class MockStream<T> extends Mock implements Stream<T> {}



void main() {
  group('RealtimeSubscription', () {
    final mockStream = MockStream<RealtimeMessage>();
    final mockCloseFunction = () async {};
    final subscription = RealtimeSubscription(stream: mockStream, close: mockCloseFunction);

    test('should have the correct stream and close function', () {
      expect(subscription.stream, equals(mockStream));
      expect(subscription.close, equals(mockCloseFunction));
    });
  });
}
