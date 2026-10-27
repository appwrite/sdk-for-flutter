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
  group('Organization test', () {
    late MockClient client;
    late Organization organization;

    setUp(() {
      client = MockClient();
      organization = Organization(client);
    });

    test('test method listInstallations()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'installations': [],
      };

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await organization.listInstallations(
        queries: [],
        total: false,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/organization/installations",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "queries": isA<List>(),
        "total": false,
      });
      expect(response, isA<models.AppInstallationList>());
    });

    test('test method createInstallation()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'appId': "5e5ea5c16897e",
        'teamId': "5e5ea5c16897e",
        'scopes': [],
        'authorizationDetails': [],
        'createdById': "5e5ea5c16897e",
        'createdByName': "Walter White",
      };

      when(
        client.call(
          HttpMethod.post,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await organization.createInstallation(
        appId: "<APP_ID>",
        authorizationDetails: "<AUTHORIZATION_DETAILS>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/organization/installations",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "appId": "<APP_ID>",
        "authorizationDetails": "<AUTHORIZATION_DETAILS>",
      });
      expect(response, isA<models.AppInstallation>());
    });

    test('test method getInstallation()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'appId': "5e5ea5c16897e",
        'teamId': "5e5ea5c16897e",
        'scopes': [],
        'authorizationDetails': [],
        'createdById': "5e5ea5c16897e",
        'createdByName': "Walter White",
      };

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await organization.getInstallation(
        installationId: "<INSTALLATION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/organization/installations/%3CINSTALLATION_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<models.AppInstallation>());
    });

    test('test method updateInstallation()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'appId': "5e5ea5c16897e",
        'teamId': "5e5ea5c16897e",
        'scopes': [],
        'authorizationDetails': [],
        'createdById': "5e5ea5c16897e",
        'createdByName': "Walter White",
      };

      when(
        client.call(
          HttpMethod.put,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await organization.updateInstallation(
        installationId: "<INSTALLATION_ID>",
        authorizationDetails: "<AUTHORIZATION_DETAILS>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/organization/installations/%3CINSTALLATION_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "authorizationDetails": "<AUTHORIZATION_DETAILS>",
      });
      expect(response, isA<models.AppInstallation>());
    });

    test('test method deleteInstallation()', () async {
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

      final response = await organization.deleteInstallation(
        installationId: "<INSTALLATION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/organization/installations/%3CINSTALLATION_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
    });
  });
}
