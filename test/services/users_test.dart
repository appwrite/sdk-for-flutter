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
    group('Users test', () {
        late MockClient client;
        late Users users;

        setUp(() {
            client = MockClient();
            users = Users(client);
        });

        test('test method deleteAuthenticator()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'name': 'John Doe',
                'registration': '2020-10-15T06:38:00.000+00:00',
                'status': true,
                'labels': [],
                'passwordUpdate': '2020-10-15T06:38:00.000+00:00',
                'email': 'john@appwrite.io',
                'phone': '+4930901820',
                'emailVerification': true,
                'phoneVerification': true,
                'mfa': true,
                'totp': true,
                'prefs': <String, dynamic>{},
                'targets': [],
                'accessedAt': '2020-10-15T06:38:00.000+00:00',};


            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await users.deleteAuthenticator(
                userId: '[USER_ID]',
                provider: 'totp',
                otp: '[OTP]',
            );
            expect(response, isA<models.User>());

        });

        test('test method listProviders()', () async {
            final Map<String, dynamic> data = {
                'totp': true,
                'phone': true,
                'email': true,};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await users.listProviders(
                userId: '[USER_ID]',
            );
            expect(response, isA<models.MfaProviders>());

        });

    });
}