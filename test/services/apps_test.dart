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
  group('Apps test', () {
    late MockClient client;
    late Apps apps;

    setUp(() {
      client = MockClient();
      apps = Apps(client);
    });

    test('test method list()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'apps': [],
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.list();
      expect(response, isA<models.AppsList>());
    });

    test('test method create()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "My Application",
        'description': "Connect your workspace to My Application.",
        'clientUri': "https://example.com",
        'logoUri': "https://example.com/logo.png",
        'privacyPolicyUrl': "https://example.com/privacy",
        'termsUrl': "https://example.com/terms",
        'contacts': [],
        'tagline': "Automate your workspace.",
        'tags': [],
        'labels': [],
        'images': [],
        'supportUrl': "https://example.com/support",
        'dataDeletionUrl': "https://example.com/data-deletion",
        'redirectUris': [],
        'postLogoutRedirectUris': [],
        'enabled': true,
        'type': "confidential",
        'deviceFlow': true,
        'teamId': "5e5ea5c16897e",
        'userId': "5e5ea5c16897e",
        'installationScopes': [],
        'installationRedirectUrl': "https://example.com/setup",
        'secrets': [],
      };

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.create(
        appId: "<APP_ID>",
        name: "<NAME>",
        redirectUris: [],
      );
      expect(response, isA<models.App>());
    });

    test('test method listInstallationScopes()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'scopes': [],
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.listInstallationScopes();
      expect(response, isA<models.AppScopeList>());
    });

    test('test method listOAuth2Scopes()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'scopes': [],
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.listOAuth2Scopes();
      expect(response, isA<models.AppScopeList>());
    });

    test('test method get()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "My Application",
        'description': "Connect your workspace to My Application.",
        'clientUri': "https://example.com",
        'logoUri': "https://example.com/logo.png",
        'privacyPolicyUrl': "https://example.com/privacy",
        'termsUrl': "https://example.com/terms",
        'contacts': [],
        'tagline': "Automate your workspace.",
        'tags': [],
        'labels': [],
        'images': [],
        'supportUrl': "https://example.com/support",
        'dataDeletionUrl': "https://example.com/data-deletion",
        'redirectUris': [],
        'postLogoutRedirectUris': [],
        'enabled': true,
        'type': "confidential",
        'deviceFlow': true,
        'teamId': "5e5ea5c16897e",
        'userId': "5e5ea5c16897e",
        'installationScopes': [],
        'installationRedirectUrl': "https://example.com/setup",
        'secrets': [],
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.get(
        appId: "<APP_ID>",
      );
      expect(response, isA<models.App>());
    });

    test('test method update()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "My Application",
        'description': "Connect your workspace to My Application.",
        'clientUri': "https://example.com",
        'logoUri': "https://example.com/logo.png",
        'privacyPolicyUrl': "https://example.com/privacy",
        'termsUrl': "https://example.com/terms",
        'contacts': [],
        'tagline': "Automate your workspace.",
        'tags': [],
        'labels': [],
        'images': [],
        'supportUrl': "https://example.com/support",
        'dataDeletionUrl': "https://example.com/data-deletion",
        'redirectUris': [],
        'postLogoutRedirectUris': [],
        'enabled': true,
        'type': "confidential",
        'deviceFlow': true,
        'teamId': "5e5ea5c16897e",
        'userId': "5e5ea5c16897e",
        'installationScopes': [],
        'installationRedirectUrl': "https://example.com/setup",
        'secrets': [],
      };

      when(
        client.call(HttpMethod.put),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.update(
        appId: "<APP_ID>",
        name: "<NAME>",
      );
      expect(response, isA<models.App>());
    });

    test('test method delete()', () async {
      final data = '';

      when(
        client.call(HttpMethod.delete),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.delete(
        appId: "<APP_ID>",
      );
    });

    test('test method listInstallations()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'installations': [],
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.listInstallations(
        appId: "<APP_ID>",
      );
      expect(response, isA<models.AppInstallationList>());
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
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.getInstallation(
        appId: "<APP_ID>",
        installationId: "<INSTALLATION_ID>",
      );
      expect(response, isA<models.AppInstallation>());
    });

    test('test method deleteInstallation()', () async {
      final data = '';

      when(
        client.call(HttpMethod.delete),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.deleteInstallation(
        appId: "<APP_ID>",
        installationId: "<INSTALLATION_ID>",
      );
    });

    test('test method createInstallationToken()', () async {
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

      final response = await apps.createInstallationToken(
        appId: "<APP_ID>",
        installationId: "<INSTALLATION_ID>",
      );
      expect(response, isA<models.Oauth2Token>());
    });

    test('test method listKeys()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'keys': [],
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.listKeys(
        appId: "<APP_ID>",
      );
      expect(response, isA<models.AppKeyList>());
    });

    test('test method createKey()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'appId': "5e5ea5c16897e",
        'secret':
            "5f3c8d2a1b9e4f7a6c8b2d1e9f4a7b3c5d8e1f2a9b4c7d6e3f5a8b1c4d7e2f9a",
        'hint': "f5c6c7",
        'createdById': "5e5ea5c16897e",
        'createdByName': "Walter White",
      };

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.createKey(
        appId: "<APP_ID>",
      );
      expect(response, isA<models.AppKey>());
    });

    test('test method getKey()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'appId': "5e5ea5c16897e",
        'secret':
            "5f3c8d2a1b9e4f7a6c8b2d1e9f4a7b3c5d8e1f2a9b4c7d6e3f5a8b1c4d7e2f9a",
        'hint': "f5c6c7",
        'createdById': "5e5ea5c16897e",
        'createdByName': "Walter White",
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.getKey(
        appId: "<APP_ID>",
        keyId: "<KEY_ID>",
      );
      expect(response, isA<models.AppKey>());
    });

    test('test method deleteKey()', () async {
      final data = '';

      when(
        client.call(HttpMethod.delete),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.deleteKey(
        appId: "<APP_ID>",
        keyId: "<KEY_ID>",
      );
    });

    test('test method listSecrets()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'secrets': [],
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.listSecrets(
        appId: "<APP_ID>",
      );
      expect(response, isA<models.AppSecretList>());
    });

    test('test method createSecret()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'appId': "5e5ea5c16897e",
        'secret':
            "5f3c8d2a1b9e4f7a6c8b2d1e9f4a7b3c5d8e1f2a9b4c7d6e3f5a8b1c4d7e2f9a",
        'hint': "f5c6c7",
        'createdById': "5e5ea5c16897e",
        'createdByName': "Walter White",
      };

      when(
        client.call(HttpMethod.post),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.createSecret(
        appId: "<APP_ID>",
      );
      expect(response, isA<models.AppSecretPlaintext>());
    });

    test('test method getSecret()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'appId': "5e5ea5c16897e",
        'secret': "",
        'hint': "f5c6c7",
        'createdById': "5e5ea5c16897e",
        'createdByName': "Walter White",
      };

      when(
        client.call(HttpMethod.get),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.getSecret(
        appId: "<APP_ID>",
        secretId: "<SECRET_ID>",
      );
      expect(response, isA<models.AppSecret>());
    });

    test('test method deleteSecret()', () async {
      final data = '';

      when(
        client.call(HttpMethod.delete),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.deleteSecret(
        appId: "<APP_ID>",
        secretId: "<SECRET_ID>",
      );
    });

    test('test method updateTeam()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "My Application",
        'description': "Connect your workspace to My Application.",
        'clientUri': "https://example.com",
        'logoUri': "https://example.com/logo.png",
        'privacyPolicyUrl': "https://example.com/privacy",
        'termsUrl': "https://example.com/terms",
        'contacts': [],
        'tagline': "Automate your workspace.",
        'tags': [],
        'labels': [],
        'images': [],
        'supportUrl': "https://example.com/support",
        'dataDeletionUrl': "https://example.com/data-deletion",
        'redirectUris': [],
        'postLogoutRedirectUris': [],
        'enabled': true,
        'type': "confidential",
        'deviceFlow': true,
        'teamId': "5e5ea5c16897e",
        'userId': "5e5ea5c16897e",
        'installationScopes': [],
        'installationRedirectUrl': "https://example.com/setup",
        'secrets': [],
      };

      when(
        client.call(HttpMethod.patch),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.updateTeam(
        appId: "<APP_ID>",
        teamId: "<TEAM_ID>",
      );
      expect(response, isA<models.App>());
    });

    test('test method deleteTokens()', () async {
      final data = '';

      when(
        client.call(HttpMethod.delete),
      ).thenAnswer((_) async => Response(data: data));

      final response = await apps.deleteTokens(
        appId: "<APP_ID>",
      );
    });
  });
}
