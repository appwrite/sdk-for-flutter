import 'dart:async';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:http/http.dart' as http;
import 'interceptor.dart';

/// Don't use this class in Browser environment
class CookieManager extends Interceptor {
  final CookieJar cookieJar;

  CookieManager(this.cookieJar);

  @override
  FutureOr<http.BaseRequest> onRequest(
    http.BaseRequest request,
  ) async {
    await cookieJar
        .loadForRequest(Uri(scheme: request.url.scheme, host: request.url.host))
        .then((cookies) {
      var cookie = getCookies(cookies);
      if (cookie.isNotEmpty) {
        request.headers.addAll({HttpHeaders.cookieHeader: cookie});
      }
      return request;
    }).catchError((e, stackTrace) {
      return request;
    });
    return request;
  }

  @override
  FutureOr<http.Response> onResponse(http.Response response) {
    _saveCookies(response).then((_) => response).catchError((e, stackTrace) {
      return response;
    });
    return response;
  }

  Future<void> _saveCookies(http.Response response) async {
    var cookie = response.headers[HttpHeaders.setCookieHeader];
    if (cookie == null) return;
    var exp = RegExp(r',(?=[^ ])');
    var cookies = cookie.split(exp);
    await cookieJar.saveFromResponse(
      Uri(
          scheme: response.request!.url.scheme,
          host: response.request!.url.host),
      cookies.map((str) => Cookie.fromSetCookieValue(str)).toList(),
    );
  }

  static String getCookies(List<Cookie> cookies) {
    return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
  }
}
