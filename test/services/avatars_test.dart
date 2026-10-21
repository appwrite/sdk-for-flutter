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
      expect(params.keys, isEmpty);
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
      expect(params.keys, isEmpty);
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
      expect(params.keys, unorderedEquals(["url"]));
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
      expect(params.keys, isEmpty);
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
      expect(params.keys, unorderedEquals(["url"]));
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

      final response = await avatars.getInitials();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/avatars/initials",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
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

      final response = await avatars.getPhoto();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/avatars/photo",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
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
      expect(params.keys, unorderedEquals(["file"]));
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
      expect(params.keys, isEmpty);
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
      expect(params.keys, unorderedEquals(["text"]));
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
      expect(params.keys, unorderedEquals(["url"]));
      expect(response, isA<Uint8List>());
    });
  });
}
