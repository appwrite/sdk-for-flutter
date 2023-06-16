import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';

import '../call_params.dart';
import '../response.dart';
import 'call_handler.dart';
import 'http_call_handler.dart';

class CookieAuthCallHandler extends CallHandler {
  final CookieJar cookieJar;

  CookieAuthCallHandler(this.cookieJar);

  @override
  Future<Response> handleCall(CallParams params) async {
    final endpoint = getEndpoint(params);
    final uri = Uri.parse(endpoint + params.path);
    try {
      final cookies = await cookieJar.loadForRequest(uri);
      var cookie =
          cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
      if (cookie.isNotEmpty) {
        params.headers.addAll({HttpHeaders.cookieHeader: cookie});
      }
    } catch (_) {}

    final response = await next.handleCall(params);

    final cookie = response.headers[HttpHeaders.setCookieHeader];
    if (cookie == null) return response;

    var exp = RegExp(r',(?=[^ ])');
    var cookies = cookie.split(exp);
    await cookieJar.saveFromResponse(
      Uri(scheme: uri.scheme, host: uri.host),
      cookies.map((str) => Cookie.fromSetCookieValue(str)).toList(),
    );

    return response;
  }
}
