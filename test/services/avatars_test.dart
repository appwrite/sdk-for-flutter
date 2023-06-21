import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:appwrite/models.dart' as models;
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
    return super.noSuchMethod(Invocation.method(#call, [method]),
        returnValue: Response());
  }

  @override
  Future webAuth(
    Uri? url, 
    {
        String? callbackUrlScheme,
    }
  ) async {
    return super.noSuchMethod(Invocation.method(#webAuth, [url]), returnValue: 'done');
  }

  @override
  Future<Response> chunkedUpload({
    String? path,
    Map<String, dynamic>? params,
    String? paramName,
    String? idParamName,
    Map<String, String>? headers,
    Function(UploadProgress)? onProgress,
  }) async {
    return super.noSuchMethod(Invocation.method(#chunkedUpload, [path, params, paramName, idParamName, headers]), returnValue: Response(data: {}));
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

        test('test method getBrowser()', () async {final Uint8List data = Uint8List.fromList([]);

            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await avatars.getBrowser(
                code: 'aa',
            );
            expect(response, isA<Uint8List>());

        });

        test('test method getCreditCard()', () async {final Uint8List data = Uint8List.fromList([]);

            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await avatars.getCreditCard(
                code: 'amex',
            );
            expect(response, isA<Uint8List>());

        });

        test('test method getFavicon()', () async {final Uint8List data = Uint8List.fromList([]);

            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await avatars.getFavicon(
                url: 'https://example.com',
            );
            expect(response, isA<Uint8List>());

        });

        test('test method getFlag()', () async {final Uint8List data = Uint8List.fromList([]);

            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await avatars.getFlag(
                code: 'af',
            );
            expect(response, isA<Uint8List>());

        });

        test('test method getImage()', () async {final Uint8List data = Uint8List.fromList([]);

            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await avatars.getImage(
                url: 'https://example.com',
            );
            expect(response, isA<Uint8List>());

        });

        test('test method getInitials()', () async {final Uint8List data = Uint8List.fromList([]);

            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await avatars.getInitials(
            );
            expect(response, isA<Uint8List>());

        });

        test('test method getQR()', () async {final Uint8List data = Uint8List.fromList([]);

            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await avatars.getQR(
                text: '[TEXT]',
            );
            expect(response, isA<Uint8List>());

        });

    });
}