import 'package:appwrite/src/cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  group('getCookies()', () {
    test('conversion', () {
      List<Cookie> cookies = [
        Cookie('name', 'value'),
        Cookie('name2', 'value2'),
      ];

      expect(
        CookieManager.getCookies(cookies),
        "name=value; name2=value2",
      );
    });
  });

  group('onRequest()', () {
    late CookieJar cookieJar;
    late CookieManager cookieManager;

    setUp(() {
      cookieJar = CookieJar();
      cookieManager = CookieManager(cookieJar);
    });

    test('without cookie', () async {
      final request = Request('GET', Uri.parse('https://appwrite.io'));
      await cookieManager.onRequest(request);
      expect(request.headers, {});
    });

    test('with cookie', () async {
      final uri = Uri.parse('https://appwrite.io');
      final cookies = [
        Cookie('name', 'value'),
        Cookie('name2', 'value2'),
      ];
      cookieJar.saveFromResponse(uri, cookies);
      
      final request = Request('GET', uri);
      await cookieManager.onRequest(request);
      expect(request.headers, {
        'cookie': 'name=value; name2=value2'
      });
    });
  });

  group('onResponse()', () {
    late CookieJar cookieJar;
    late CookieManager cookieManager;

    setUp(() {
      cookieJar = CookieJar();
      cookieManager = CookieManager(cookieJar);
    });

    test('without cookie', () async {
      final uri = Uri.parse('https://appwrite.io');
      final request = Request('POST', uri);
      final response = Response(
        'body',
        200,
        headers: {},
        request: request,
      );

      await cookieManager.onResponse(response);

      final cookies = await cookieJar.loadForRequest(uri);

      expect(cookies, []);
    });

    test('with cookie', () async {
      final uri = Uri.parse('https://appwrite.io');
      final request = Request('POST', uri);
      final response = Response(
        'body',
        200,
        headers: {
          'set-cookie': 'name=value'
        },
        request: request,
      );
      
      await cookieManager.onResponse(response);

      final cookies = await cookieJar.loadForRequest(uri);

      expect(cookies.length, 1);
      expect(cookies.first.name, 'name');
      expect(cookies.first.value, 'value');
    });
  });
}