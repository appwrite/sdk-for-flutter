import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite/enums.dart' as enums;
import 'package:appwrite/src/enums.dart';
import 'package:appwrite/src/response.dart';
import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';

class MockClient extends Mock implements Client {
  Map<String, String> config = {'project': 'testproject'};
  String endPoint = 'https://localhost/v1';

  @override
  Future<Response> call(
    HttpMethod? method, {
    String? path = '',
    Map<String, String>? headers = const {},
    Map<String, dynamic>? params = const {},
    ResponseType? responseType,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#call, [method], {
        #path: path,
        #headers: headers,
        #params: params,
        #responseType: responseType,
      }),
      returnValue: Response(),
    );
  }

  @override
  Future webAuth(Uri? url, {String? callbackUrlScheme}) async {
    return super.noSuchMethod(
      Invocation.method(#webAuth, [url]),
      returnValue: 'done',
    );
  }

  @override
  Future<Response> chunkedUpload({
    String? path,
    Map<String, dynamic>? params,
    String? paramName,
    String? idParamName,
    Map<String, String>? headers,
    Function(UploadProgress)? onProgress,
    ResponseType? responseType,
    HttpMethod? method = HttpMethod.post,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#chunkedUpload, [], {
        #path: path,
        #params: params,
        #paramName: paramName,
        #idParamName: idParamName,
        #headers: headers,
        #method: method,
      }),
      returnValue: Response(data: {}),
    );
  }
}

void main() {
  group('Avatars test', () {
    late MockClient client;
    late Avatars avatars;

    setUp(() {
      client = MockClient();
      avatars = Avatars(client);
    });

    test('test method getBrowser()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getBrowser(
        code: enums.Browser.avantBrowser,
        width: 1,
        height: 1,
        quality: 1,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/avatars/browsers/aa",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "width": 1,
        "height": 1,
        "quality": 1,
      });
      expect(response, isA<Uint8List>());
    });

    test('test method getCreditCard()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getCreditCard(
        code: enums.CreditCard.americanExpress,
        width: 1,
        height: 1,
        quality: 1,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/avatars/credit-cards/amex",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "width": 1,
        "height": 1,
        "quality": 1,
      });
      expect(response, isA<Uint8List>());
    });

    test('test method getFavicon()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getFavicon(
        url: "https://example.com",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/avatars/favicon",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "url": "https://example.com",
      });
      expect(response, isA<Uint8List>());
    });

    test('test method getFlag()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getFlag(
        code: enums.Flag.afghanistan,
        width: 1,
        height: 1,
        quality: 1,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/avatars/flags/af",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "width": 1,
        "height": 1,
        "quality": 1,
      });
      expect(response, isA<Uint8List>());
    });

    test('test method getImage()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getImage(
        url: "https://example.com",
        width: 1,
        height: 1,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/avatars/image",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "url": "https://example.com",
        "width": 1,
        "height": 1,
      });
      expect(response, isA<Uint8List>());
    });

    test('test method getInitials()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getInitials(
        name: "<NAME>",
        width: 1,
        height: 1,
        background: "FFFFFF",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/avatars/initials",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "name": "<NAME>",
        "width": 1,
        "height": 1,
        "background": "FFFFFF",
      });
      expect(response, isA<Uint8List>());
    });

    test('test method getPhoto()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getPhoto(
        width: 1,
        height: 1,
        quality: 1,
        output: "png",
        rating: "g",
        userId: "current()",
        emailHash: "<EMAIL_HASH>",
        name: "<NAME>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/avatars/photo",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "width": 1,
        "height": 1,
        "quality": 1,
        "output": "png",
        "rating": "g",
        "userId": "current()",
        "emailHash": "<EMAIL_HASH>",
        "name": "<NAME>",
      });
      expect(response, isA<Uint8List>());
    });

    test('test method updatePhoto()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "John Doe",
        'registration': "2020-10-15T06:38:00.000+00:00",
        'status': true,
        'labels': [],
        'passwordUpdate': "2020-10-15T06:38:00.000+00:00",
        'email': "john@appwrite.io",
        'phone': "+4930901820",
        'emailVerification': true,
        'phoneVerification': true,
        'mfa': true,
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': "2020-10-15T06:38:00.000+00:00",
      };

      when(
        client.chunkedUpload(
          path: anyNamed('path'),
          params: anyNamed('params'),
          paramName: anyNamed('paramName'),
          idParamName: anyNamed('idParamName'),
          headers: anyNamed('headers'),
          method: anyNamed('method'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.updatePhoto(
        file: InputFile.fromPath(path: './image.png'),
      );
      final Map<String, dynamic> params = verify(
        client.chunkedUpload(
          path: "/avatars/photo",
          params: captureAnyNamed('params'),
          paramName: anyNamed('paramName'),
          idParamName: anyNamed('idParamName'),
          headers: anyNamed('headers'),
          method: HttpMethod.put,
        ),
      ).captured.single;
      expect(params, {
        "file": isA<InputFile>(),
      });
      expect(response, isA<models.Account>());
    });

    test('test method deletePhoto()', () async {
      final data = '';

      when(
        client.call(
          HttpMethod.delete,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.deletePhoto();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/avatars/photo",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
    });

    test('test method getQR()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getQR(
        text: "<TEXT>",
        size: 1,
        margin: 1,
        download: false,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/avatars/qr",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "text": "<TEXT>",
        "size": 1,
        "margin": 1,
        "download": false,
      });
      expect(response, isA<Uint8List>());
    });

    test('test method getScreenshot()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getScreenshot(
        url: "https://example.com",
        headers: {},
        viewportWidth: 1,
        viewportHeight: 1,
        scale: 1.0,
        theme: enums.BrowserTheme.dark,
        userAgent: "Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15",
        fullpage: false,
        locale: "en-US",
        timezone: enums.Timezone.africaAbidjan,
        latitude: 1.0,
        longitude: 1.0,
        accuracy: 1.0,
        touch: false,
        permissions: [enums.BrowserPermission.geolocation, enums.BrowserPermission.notifications],
        sleep: 1,
        width: 1,
        height: 1,
        quality: 1,
        output: enums.ImageFormat.jpeg,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/avatars/screenshots",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "url": "https://example.com",
        "headers": isA<Map>(),
        "viewportWidth": 1,
        "viewportHeight": 1,
        "scale": 1.0,
        "theme": enums.BrowserTheme.dark.value,
        "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15",
        "fullpage": false,
        "locale": "en-US",
        "timezone": enums.Timezone.africaAbidjan.value,
        "latitude": 1.0,
        "longitude": 1.0,
        "accuracy": 1.0,
        "touch": false,
        "permissions": isA<List>(),
        "sleep": 1,
        "width": 1,
        "height": 1,
        "quality": 1,
        "output": enums.ImageFormat.jpeg.value,
      });
      expect(response, isA<Uint8List>());
    });
  });
}
