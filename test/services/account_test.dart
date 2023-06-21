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
    group('Account test', () {
        late MockClient client;
        late Account account;

        setUp(() {
            client = MockClient();
            account = Account(client);
        });

        test('test method get()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                'name': 'John Doe',
                'registration': 1592981250,
                'status': true,
                'passwordUpdate': 1592981250,
                'email': 'john@appwrite.io',
                'emailVerification': true,
                'prefs': <String, dynamic>{},};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.get(
            );
            expect(response, isA<models.User>());

        });

        test('test method create()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                'name': 'John Doe',
                'registration': 1592981250,
                'status': true,
                'passwordUpdate': 1592981250,
                'email': 'john@appwrite.io',
                'emailVerification': true,
                'prefs': <String, dynamic>{},};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.create(
                userId: '[USER_ID]',
                email: 'email@example.com',
                password: 'password',
            );
            expect(response, isA<models.User>());

        });

        test('test method delete()', () async {
            final data = '';

            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.delete(
            );
        });

        test('test method updateEmail()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                'name': 'John Doe',
                'registration': 1592981250,
                'status': true,
                'passwordUpdate': 1592981250,
                'email': 'john@appwrite.io',
                'emailVerification': true,
                'prefs': <String, dynamic>{},};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.updateEmail(
                email: 'email@example.com',
                password: 'password',
            );
            expect(response, isA<models.User>());

        });

        test('test method createJWT()', () async {
            final Map<String, dynamic> data = {
                'jwt': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.createJWT(
            );
            expect(response, isA<models.Jwt>());

        });

        test('test method getLogs()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'logs': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.getLogs(
            );
            expect(response, isA<models.LogList>());

        });

        test('test method updateName()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                'name': 'John Doe',
                'registration': 1592981250,
                'status': true,
                'passwordUpdate': 1592981250,
                'email': 'john@appwrite.io',
                'emailVerification': true,
                'prefs': <String, dynamic>{},};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.updateName(
                name: '[NAME]',
            );
            expect(response, isA<models.User>());

        });

        test('test method updatePassword()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                'name': 'John Doe',
                'registration': 1592981250,
                'status': true,
                'passwordUpdate': 1592981250,
                'email': 'john@appwrite.io',
                'emailVerification': true,
                'prefs': <String, dynamic>{},};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.updatePassword(
                password: 'password',
            );
            expect(response, isA<models.User>());

        });

        test('test method getPrefs()', () async {
            final Map<String, dynamic> data = {};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.getPrefs(
            );
            expect(response, isA<models.Preferences>());

        });

        test('test method updatePrefs()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                'name': 'John Doe',
                'registration': 1592981250,
                'status': true,
                'passwordUpdate': 1592981250,
                'email': 'john@appwrite.io',
                'emailVerification': true,
                'prefs': <String, dynamic>{},};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.updatePrefs(
                prefs: {},
            );
            expect(response, isA<models.User>());

        });

        test('test method createRecovery()', () async {
            final Map<String, dynamic> data = {
                '\$id': 'bb8ea5c16897e',
                'userId': '5e5ea5c168bb8',
                'secret': '',
                'expire': 1592981250,};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.createRecovery(
                email: 'email@example.com',
                url: 'https://example.com',
            );
            expect(response, isA<models.Token>());

        });

        test('test method updateRecovery()', () async {
            final Map<String, dynamic> data = {
                '\$id': 'bb8ea5c16897e',
                'userId': '5e5ea5c168bb8',
                'secret': '',
                'expire': 1592981250,};


            when(client.call(
                HttpMethod.put,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.updateRecovery(
                userId: '[USER_ID]',
                secret: '[SECRET]',
                password: 'password',
                passwordAgain: 'password',
            );
            expect(response, isA<models.Token>());

        });

        test('test method getSessions()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'sessions': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.getSessions(
            );
            expect(response, isA<models.SessionList>());

        });

        test('test method createSession()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                'userId': '5e5bb8c16897e',
                'expire': 1592981250,
                'provider': 'email',
                'providerUid': 'user@example.com',
                'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
                'providerAccessTokenExpiry': 1592981250,
                'providerRefreshToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
                'ip': '127.0.0.1',
                'osCode': 'Mac',
                'osName': 'Mac',
                'osVersion': 'Mac',
                'clientType': 'browser',
                'clientCode': 'CM',
                'clientName': 'Chrome Mobile iOS',
                'clientVersion': '84.0',
                'clientEngine': 'WebKit',
                'clientEngineVersion': '605.1.15',
                'deviceName': 'smartphone',
                'deviceBrand': 'Google',
                'deviceModel': 'Nexus 5',
                'countryCode': 'US',
                'countryName': 'United States',
                'current': true,};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.createSession(
                email: 'email@example.com',
                password: 'password',
            );
            expect(response, isA<models.Session>());

        });

        test('test method deleteSessions()', () async {
            final data = '';

            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.deleteSessions(
            );
        });

        test('test method createAnonymousSession()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                'userId': '5e5bb8c16897e',
                'expire': 1592981250,
                'provider': 'email',
                'providerUid': 'user@example.com',
                'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
                'providerAccessTokenExpiry': 1592981250,
                'providerRefreshToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
                'ip': '127.0.0.1',
                'osCode': 'Mac',
                'osName': 'Mac',
                'osVersion': 'Mac',
                'clientType': 'browser',
                'clientCode': 'CM',
                'clientName': 'Chrome Mobile iOS',
                'clientVersion': '84.0',
                'clientEngine': 'WebKit',
                'clientEngineVersion': '605.1.15',
                'deviceName': 'smartphone',
                'deviceBrand': 'Google',
                'deviceModel': 'Nexus 5',
                'countryCode': 'US',
                'countryName': 'United States',
                'current': true,};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.createAnonymousSession(
            );
            expect(response, isA<models.Session>());

        });

        test('test method createMagicURLSession()', () async {
            final Map<String, dynamic> data = {
                '\$id': 'bb8ea5c16897e',
                'userId': '5e5ea5c168bb8',
                'secret': '',
                'expire': 1592981250,};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.createMagicURLSession(
                userId: '[USER_ID]',
                email: 'email@example.com',
            );
            expect(response, isA<models.Token>());

        });

        test('test method updateMagicURLSession()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                'userId': '5e5bb8c16897e',
                'expire': 1592981250,
                'provider': 'email',
                'providerUid': 'user@example.com',
                'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
                'providerAccessTokenExpiry': 1592981250,
                'providerRefreshToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
                'ip': '127.0.0.1',
                'osCode': 'Mac',
                'osName': 'Mac',
                'osVersion': 'Mac',
                'clientType': 'browser',
                'clientCode': 'CM',
                'clientName': 'Chrome Mobile iOS',
                'clientVersion': '84.0',
                'clientEngine': 'WebKit',
                'clientEngineVersion': '605.1.15',
                'deviceName': 'smartphone',
                'deviceBrand': 'Google',
                'deviceModel': 'Nexus 5',
                'countryCode': 'US',
                'countryName': 'United States',
                'current': true,};


            when(client.call(
                HttpMethod.put,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.updateMagicURLSession(
                userId: '[USER_ID]',
                secret: '[SECRET]',
            );
            expect(response, isA<models.Session>());

        });

        test('test method createOAuth2Session()', () async {

            when(client.webAuth(
                Uri(),
            )).thenAnswer((_) async => 'done');


            final response = await account.createOAuth2Session(
                provider: 'amazon',
            );
        });

        test('test method getSession()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                'userId': '5e5bb8c16897e',
                'expire': 1592981250,
                'provider': 'email',
                'providerUid': 'user@example.com',
                'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
                'providerAccessTokenExpiry': 1592981250,
                'providerRefreshToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
                'ip': '127.0.0.1',
                'osCode': 'Mac',
                'osName': 'Mac',
                'osVersion': 'Mac',
                'clientType': 'browser',
                'clientCode': 'CM',
                'clientName': 'Chrome Mobile iOS',
                'clientVersion': '84.0',
                'clientEngine': 'WebKit',
                'clientEngineVersion': '605.1.15',
                'deviceName': 'smartphone',
                'deviceBrand': 'Google',
                'deviceModel': 'Nexus 5',
                'countryCode': 'US',
                'countryName': 'United States',
                'current': true,};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.getSession(
                sessionId: '[SESSION_ID]',
            );
            expect(response, isA<models.Session>());

        });

        test('test method updateSession()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                'userId': '5e5bb8c16897e',
                'expire': 1592981250,
                'provider': 'email',
                'providerUid': 'user@example.com',
                'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
                'providerAccessTokenExpiry': 1592981250,
                'providerRefreshToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
                'ip': '127.0.0.1',
                'osCode': 'Mac',
                'osName': 'Mac',
                'osVersion': 'Mac',
                'clientType': 'browser',
                'clientCode': 'CM',
                'clientName': 'Chrome Mobile iOS',
                'clientVersion': '84.0',
                'clientEngine': 'WebKit',
                'clientEngineVersion': '605.1.15',
                'deviceName': 'smartphone',
                'deviceBrand': 'Google',
                'deviceModel': 'Nexus 5',
                'countryCode': 'US',
                'countryName': 'United States',
                'current': true,};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.updateSession(
                sessionId: '[SESSION_ID]',
            );
            expect(response, isA<models.Session>());

        });

        test('test method deleteSession()', () async {
            final data = '';

            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.deleteSession(
                sessionId: '[SESSION_ID]',
            );
        });

        test('test method createVerification()', () async {
            final Map<String, dynamic> data = {
                '\$id': 'bb8ea5c16897e',
                'userId': '5e5ea5c168bb8',
                'secret': '',
                'expire': 1592981250,};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.createVerification(
                url: 'https://example.com',
            );
            expect(response, isA<models.Token>());

        });

        test('test method updateVerification()', () async {
            final Map<String, dynamic> data = {
                '\$id': 'bb8ea5c16897e',
                'userId': '5e5ea5c168bb8',
                'secret': '',
                'expire': 1592981250,};


            when(client.call(
                HttpMethod.put,
            )).thenAnswer((_) async => Response(data: data));


            final response = await account.updateVerification(
                userId: '[USER_ID]',
                secret: '[SECRET]',
            );
            expect(response, isA<models.Token>());

        });

    });
}