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
    return super.noSuchMethod(Invocation.method(#call, [method]),
        returnValue: Response());
  }

  @override
  Future webAuth(
    Uri? url, {
    String? callbackUrlScheme,
  }) async {
    return super
        .noSuchMethod(Invocation.method(#webAuth, [url]), returnValue: 'done');
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
    return super.noSuchMethod(
        Invocation.method(
            #chunkedUpload, [path, params, paramName, idParamName, headers]),
        returnValue: Response(data: {}));
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
        'redirectUrl': 'https://example.com/callback?code=abcde&state=fghij',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.approve(
        projectId: '<PROJECT_ID>',
        grantId: '<GRANT_ID>',
      );
      expect(response, isA<models.Oauth2Approve>());
    });

    test('test method authorize()', () async {
      final Map<String, dynamic> data = {
        'grantId': '5e5ea5c16897e',
        'redirectUrl': 'https://example.com/callback?code=abcde&state=fghij',
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.authorize(
        projectId: '<PROJECT_ID>',
        clientId: '<CLIENT_ID>',
        redirectUri: 'https://example.com',
        responseType: 'code',
        scope: '<SCOPE>',
      );
      expect(response, isA<models.Oauth2Authorize>());
    });

    test('test method createGrant()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c16897e',
        'appId': '5e5ea5c16897e',
        'scopes': [],
        'authorizationDetails':
            '[{\"type\":\"calendar\",\"identifier\":\"primary\",\"actions\":[\"read_events\",\"create_event\"]}]',
        'prompt': 'login',
        'redirectUri': 'https://example.com/callback',
        'authTime': 1592981250,
        'expire': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.createGrant(
        projectId: '<PROJECT_ID>',
        userCode: '<USER_CODE>',
      );
      expect(response, isA<models.Oauth2Grant>());
    });

    test('test method getGrant()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c16897e',
        'appId': '5e5ea5c16897e',
        'scopes': [],
        'authorizationDetails':
            '[{\"type\":\"calendar\",\"identifier\":\"primary\",\"actions\":[\"read_events\",\"create_event\"]}]',
        'prompt': 'login',
        'redirectUri': 'https://example.com/callback',
        'authTime': 1592981250,
        'expire': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.getGrant(
        projectId: '<PROJECT_ID>',
        grantId: '<GRANT_ID>',
      );
      expect(response, isA<models.Oauth2Grant>());
    });

    test('test method reject()', () async {
      final Map<String, dynamic> data = {
        'redirectUrl':
            'https://example.com/callback?error=access_denied&state=fghij',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await oauth2.reject(
        projectId: '<PROJECT_ID>',
        grantId: '<GRANT_ID>',
      );
      expect(response, isA<models.Oauth2Reject>());
    });
  });
}
