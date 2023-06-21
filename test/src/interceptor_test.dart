import 'dart:async';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:appwrite/src/interceptor.dart';

class MockRequest extends Mock implements BaseRequest {
  final Map<String, String> headers = {};

  @override
  Future<StreamedResponse> send() async {
    final response = StreamedResponse(ByteStream.fromBytes([]), 200);
    response.headers.addAll(headers);
    return response;
  }
}

void main() {
  group('HeadersInterceptor', () {
    test('onRequest should add headers to the request', () async {
      final headers = {'Authorization': 'Bearer token123'};
      final interceptor = HeadersInterceptor(headers);
      final request = MockRequest();

      final interceptedRequest = await interceptor.onRequest(request);

      expect(interceptedRequest.headers, equals(headers));
    });

    test('onResponse should return the same response', () async {
      final response = Response('', 200);
      final interceptor = HeadersInterceptor({});

      final interceptedResponse = await interceptor.onResponse(response);

      expect(interceptedResponse, equals(response));
    });
  });
}
