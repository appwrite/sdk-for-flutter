import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

import '../call_params.dart';
import '../response.dart';
import 'call_handler.dart';

const _cookieFallbackKey = 'cookieFallback';

class FallbackAuthCallHandler extends CallHandler {
  FallbackAuthCallHandler();

  @override
  Future<Response> handleCall(CallParams params) async {
    if (html.window.localStorage.keys.contains(_cookieFallbackKey)) {
      final cookieFallback = html.window.localStorage[_cookieFallbackKey];
      params.headers.addAll({'x-fallback-cookies': cookieFallback!});
    }

    final response = await next.handleCall(params);

    final cookieFallback = response.headers['x-fallback-cookies'];
    if (cookieFallback != null) {
      debugPrint(
          'Appwrite is using localStorage for session management. Increase your security by adding a custom domain as your API endpoint.');
      html.window.localStorage[_cookieFallbackKey] = cookieFallback;
    }

    return response;
  }
}
