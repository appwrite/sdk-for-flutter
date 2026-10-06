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
  group('Oauth2 test', () {
    late MockClient client;
    late Oauth2 oauth2;

    setUp(() {
      client = MockClient();
      oauth2 = Oauth2(client);
    });

    test('test method approve()', () async {
      final Map<String, dynamic> data = {
        'redirectUrl': "https://example.com/callback?code=abcde&state=fghij",
      };

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.approve(
        grantId: "<GRANT_ID>",
      );
      expect(response, isA<models.Oauth2Approve>());
    });

    test('test method authorize()', () async {
      final Map<String, dynamic> data = {
        'grantId': "5e5ea5c16897e",
        'redirectUrl': "https://example.com/callback?code=abcde&state=fghij",
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.authorize();
      expect(response, isA<models.Oauth2Authorize>());
    });

    test('test method authorizePost()', () async {
      final Map<String, dynamic> data = {
        'grantId': "5e5ea5c16897e",
        'redirectUrl': "https://example.com/callback?code=abcde&state=fghij",
      };

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.authorizePost();
      expect(response, isA<models.Oauth2Authorize>());
    });

    test('test method createDeviceAuthorization()', () async {
      final Map<String, dynamic> data = {
        'device_code':
            "5f3c8d2a1b9e4f7a6c8b2d1e9f4a7b3c5d8e1f2a9b4c7d6e3f5a8b1c4d7e2f9a",
        'user_code': "ABCD-EFGH",
        'verification_uri': "https://appwrite.io/oauth2/device",
        'verification_uri_complete':
            "https://appwrite.io/oauth2/device?user_code=ABCD-EFGH",
        'expires_in': 900,
        'interval': 5,
      };

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.createDeviceAuthorization();
      expect(response, isA<models.Oauth2DeviceAuthorization>());
    });

    test('test method createGrant()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c16897e",
        'appId': "5e5ea5c16897e",
        'scopes': [],
        'resources': [],
        'authorizationDetails':
            "[{\"type\":\"calendar\",\"identifier\":\"primary\",\"actions\":[\"read_events\",\"create_event\"]}]",
        'prompt': "login",
        'redirectUri': "https://example.com/callback",
        'authTime': 1592981250,
        'expire': "2020-10-15T06:38:00.000+00:00",
      };

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.createGrant(
        userCode: "<USER_CODE>",
      );
      expect(response, isA<models.Oauth2Grant>());
    });

    test('test method getGrant()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c16897e",
        'appId': "5e5ea5c16897e",
        'scopes': [],
        'resources': [],
        'authorizationDetails':
            "[{\"type\":\"calendar\",\"identifier\":\"primary\",\"actions\":[\"read_events\",\"create_event\"]}]",
        'prompt': "login",
        'redirectUri': "https://example.com/callback",
        'authTime': 1592981250,
        'expire': "2020-10-15T06:38:00.000+00:00",
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.getGrant(
        grantId: "<GRANT_ID>",
      );
      expect(response, isA<models.Oauth2Grant>());
    });

    test('test method logout()', () async {
      final data = '';

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.logout();
    });

    test('test method logoutPost()', () async {
      final data = '';

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.logoutPost();
    });

    test('test method listOrganizations()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'organizations': [],
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.listOrganizations();
      expect(response, isA<models.Oauth2OrganizationList>());
    });

    test('test method createPAR()', () async {
      final Map<String, dynamic> data = {
        'request_uri': "urn:appwrite:oauth2:request:5e5ea5c16897e",
        'expires_in': 600,
      };

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.createPAR(
        clientId: "<CLIENT_ID>",
        redirectUri: "https://example.com",
        responseType: "code",
      );
      expect(response, isA<models.Oauth2PAR>());
    });

    test('test method listProjects()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'projects': [],
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.listProjects();
      expect(response, isA<models.Oauth2ProjectList>());
    });

    test('test method reject()', () async {
      final Map<String, dynamic> data = {
        'redirectUrl':
            "https://example.com/callback?error=access_denied&state=fghij",
      };

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.reject(
        grantId: "<GRANT_ID>",
      );
      expect(response, isA<models.Oauth2Reject>());
    });

    test('test method revoke()', () async {
      final data = '';

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.revoke(
        token: "<TOKEN>",
      );
    });

    test('test method createToken()', () async {
      final Map<String, dynamic> data = {
        'access_token': "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9...",
        'token_type': "Bearer",
        'expires_in': 3600,
        'refresh_token': "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
        'scope': "openid email profile",
      };

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.createToken(
        grantType: "<GRANT_TYPE>",
      );
      expect(response, isA<models.Oauth2Token>());
    });
  });
}
