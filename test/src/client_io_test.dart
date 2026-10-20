import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appwrite/src/client_io.dart';
import 'package:appwrite/src/exception.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  late HttpServer server;
  late Directory documents;
  late ClientIO client;
  late List<Map<String, dynamic>> authentications;
  late List<String> requests;
  late String Function(String callback) respond;

  setUp(() async {
    HttpOverrides.global = null;
    documents = await Directory.systemTemp.createTemp();
    messenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (call) async => documents.path,
    );
    authentications = [];
    messenger.setMockMethodCallHandler(
      const MethodChannel('flutter_web_auth_2'),
      (call) async {
        final arguments = Map<String, dynamic>.from(call.arguments as Map);
        authentications.add(arguments);
        return respond(arguments['callbackUrlScheme'] as String);
      },
    );

    requests = [];
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((request) async {
      requests.add(
        '${request.method} ${request.uri.path} ${await utf8.decoder.bind(request).join()}',
      );
      request.response
        ..headers.contentType = ContentType.json
        ..cookies.add(Cookie('a_session_project', 'session'))
        ..write('{}');
      await request.response.close();
    });

    client = ClientIO(endPoint: 'http://127.0.0.1:${server.port}/v1');
    client.config['project'] = 'project';
  });

  tearDown(() async {
    debugDefaultTargetPlatformOverride = null;
    messenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      null,
    );
    messenger.setMockMethodCallHandler(
      const MethodChannel('flutter_web_auth_2'),
      null,
    );
    await server.close(force: true);
    await documents.delete(recursive: true);
  });

  Uri authorization() => Uri.parse(
    'http://127.0.0.1:${server.port}/v1/account/sessions/oauth2/github?scopes%5B%5D=user&scopes%5B%5D=repo&project=project',
  );

  Future<List<String>> cookies() async =>
      (await client.cookieJar.loadForRequest(
        Uri.parse('http://127.0.0.1:${server.port}/v1'),
      )).map((cookie) => '${cookie.name}=${cookie.value}').toList();

  for (final platform in [TargetPlatform.linux, TargetPlatform.windows]) {
    group('webAuth on ${platform.name}', () {
      setUp(() => debugDefaultTargetPlatformOverride = platform);

      test('signs in through a loopback token callback', () async {
        respond = (callback) => '$callback?userId=user&secret=token';

        await client.webAuth(authorization());

        final callback = authentications.single['callbackUrlScheme'] as String;
        expect(callback, matches(RegExp(r'^http://localhost:\d+/$')));
        final url = Uri.parse(authentications.single['url'] as String);
        expect(url.path, '/v1/account/tokens/oauth2/github');
        expect(url.queryParametersAll['scopes[]'], ['user', 'repo']);
        expect(url.queryParameters['project'], 'project');
        expect(url.queryParameters['success'], callback);
        expect(url.queryParameters['failure'], callback);
        expect(requests, [
          'POST /v1/account/sessions/token {"userId":"user","secret":"token"}',
        ]);
        expect(await cookies(), ['a_session_project=session']);
      });

      test('keeps the success and failure URLs it is given', () async {
        respond = (callback) => '$callback?userId=user&secret=token';

        await client.webAuth(
          authorization().replace(
            queryParameters: {
              ...authorization().queryParametersAll,
              'success': 'http://localhost:4000/auth',
              'failure': 'http://localhost:4000/failed',
            },
          ),
          callbackUrlScheme: 'http://localhost:4000/auth',
        );

        expect(
          authentications.single['callbackUrlScheme'],
          'http://localhost:4000/auth',
        );
        final url = Uri.parse(authentications.single['url'] as String);
        expect(url.queryParameters['success'], 'http://localhost:4000/auth');
        expect(url.queryParameters['failure'], 'http://localhost:4000/failed');
        expect(requests, hasLength(1));
      });

      test('throws the error the callback carries', () async {
        respond = (callback) =>
            '$callback?error=${Uri.encodeComponent('{"message":"Denied","code":401,"type":"user_oauth2_unauthorized"}')}';

        await expectLater(
          client.webAuth(authorization()),
          throwsA(
            isA<AppwriteException>()
                .having((error) => error.message, 'message', 'Denied')
                .having((error) => error.code, 'code', 401),
          ),
        );
        expect(requests, isEmpty);
      });
    });
  }

  test('webAuth on android saves the session from the app callback', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    respond = (callback) => '$callback://?key=a_session_project&secret=session';

    await client.webAuth(authorization());

    expect(
      authentications.single['callbackUrlScheme'],
      'appwrite-callback-project',
    );
    expect(authentications.single['url'], authorization().toString());
    expect(requests, isEmpty);
    expect(await cookies(), ['a_session_project=session']);
  });
}
