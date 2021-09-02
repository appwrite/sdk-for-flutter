import 'dart:async';

import 'package:http/http.dart';

class Interceptor {
  FutureOr<Response> onResponse(Response response) => response;
  FutureOr<BaseRequest> onRequest(BaseRequest request) => request;
}

class HeadersInterceptor extends Interceptor {
  final Map<String, String> headers;

  HeadersInterceptor(this.headers);

  @override
  BaseRequest onRequest(BaseRequest request) {
    request.headers.addAll(headers);
    return request;
  }
}
