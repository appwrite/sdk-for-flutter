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
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#call, [method]),
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
    HttpMethod method = HttpMethod.post,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#chunkedUpload, [
        path,
        params,
        paramName,
        idParamName,
        headers,
      ]),
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
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getBrowser(
        code: enums.Browser.avantBrowser,
      );
      expect(response, isA<Uint8List>());
    });

    test('test method getCreditCard()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getCreditCard(
        code: enums.CreditCard.americanExpress,
      );
      expect(response, isA<Uint8List>());
    });

    test('test method getFavicon()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getFavicon(
        url: "https://example.com",
      );
      expect(response, isA<Uint8List>());
    });

    test('test method getFlag()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getFlag(
        code: enums.Flag.afghanistan,
      );
      expect(response, isA<Uint8List>());
    });

    test('test method getImage()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getImage(
        url: "https://example.com",
      );
      expect(response, isA<Uint8List>());
    });

    test('test method getInitials()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getInitials();
      expect(response, isA<Uint8List>());
    });

    test('test method getPhoto()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getPhoto();
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
          path: argThat(isNotNull),
          params: argThat(isNotNull),
          paramName: argThat(isNotNull),
          idParamName: argThat(isNotNull),
          headers: argThat(isNotNull),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.updatePhoto(
        file: InputFile.fromPath(path: './image.png'),
      );
      expect(response, isA<models.Account>());
    });

    test('test method deletePhoto()', () async {
      final data = '';

      when(
        client.call(HttpMethod.delete),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.deletePhoto();
    });

    test('test method getQR()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getQR(
        text: "<TEXT>",
      );
      expect(response, isA<Uint8List>());
    });

    test('test method getScreenshot()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await avatars.getScreenshot(
        url: "https://example.com",
      );
      expect(response, isA<Uint8List>());
    });
  });
}
