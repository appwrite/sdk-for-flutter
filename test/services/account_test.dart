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
  group('Account test', () {
    late MockClient client;
    late Account account;

    setUp(() {
      client = MockClient();
      account = Account(client);
    });

    test('test method get()', () async {
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
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.get();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.User>());
    });

    test('test method create()', () async {
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
        client.call(
          HttpMethod.post,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.create(
        userId: "<USER_ID>",
        email: "email@example.com",
        password: "password",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "email", "password"]));
      expect(response, isA<models.User>());
    });

    test('test method listConsents()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'consents': [],
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

      final response = await account.listConsents();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/consents",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Oauth2ConsentList>());
    });

    test('test method getConsent()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c16897e",
        'appId': "5e5ea5c16897e",
        'cimdUrl': "https://example.com/.well-known/client-metadata.json",
        'scopes': [],
        'resources': [],
        'authorizationDetails':
            "[{\"type\":\"calendar\",\"identifier\":\"primary\",\"actions\":[\"read_events\",\"create_event\"]}]",
        'expire': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.getConsent(
        consentId: "<CONSENT_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/consents/<CONSENT_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Oauth2Consent>());
    });

    test('test method deleteConsent()', () async {
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

      final response = await account.deleteConsent(
        consentId: "<CONSENT_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/account/consents/<CONSENT_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
    });

    test('test method listConsentTokens()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'tokens': [],
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

      final response = await account.listConsentTokens(
        consentId: "<CONSENT_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/consents/<CONSENT_ID>/tokens",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Oauth2ConsentTokenList>());
    });

    test('test method getConsentToken()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'consentId': "5e5ea5c16897e",
        'userId': "5e5ea5c16897e",
        'appId': "5e5ea5c16897e",
        'cimdUrl': "https://example.com/.well-known/client-metadata.json",
        'scopes': [],
        'resources': [],
        'authorizationDetails':
            "[{\"type\":\"calendar\",\"identifier\":\"primary\",\"actions\":[\"read_events\",\"create_event\"]}]",
        'expire': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.getConsentToken(
        consentId: "<CONSENT_ID>",
        tokenId: "<TOKEN_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/consents/<CONSENT_ID>/tokens/<TOKEN_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Oauth2ConsentToken>());
    });

    test('test method deleteConsentToken()', () async {
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

      final response = await account.deleteConsentToken(
        consentId: "<CONSENT_ID>",
        tokenId: "<TOKEN_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/account/consents/<CONSENT_ID>/tokens/<TOKEN_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
    });

    test('test method updateEmail()', () async {
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
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updateEmail(
        email: "email@example.com",
        password: "password",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/account/email",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["email", "password"]));
      expect(response, isA<models.User>());
    });

    test('test method listIdentities()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'identities': [],
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

      final response = await account.listIdentities();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/identities",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.IdentityList>());
    });

    test('test method deleteIdentity()', () async {
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

      final response = await account.deleteIdentity(
        identityId: "<IDENTITY_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/account/identities/<IDENTITY_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
    });

    test('test method createJWT()', () async {
      final Map<String, dynamic> data = {
        'jwt':
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
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

      final response = await account.createJWT();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/jwts",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Jwt>());
    });

    test('test method listMemberships()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'memberships': [],
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

      final response = await account.listMemberships();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/memberships",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.MembershipList>());
    });

    test('test method updateMFA()', () async {
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
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMFA(
        mfa: true,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/account/mfa",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["mfa"]));
      expect(response, isA<models.User>());
    });

    test('test method createMfaAuthenticator()', () async {
      final Map<String, dynamic> data = {
        'secret': "[SHARED_SECRET]",
        'uri':
            "otpauth://totp/appwrite:user@example.com?secret=[SHARED_SECRET]&issuer=appwrite",
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

      final response = await account.createMfaAuthenticator(
        type: enums.AuthenticatorType.totp,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/mfa/authenticators/totp",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.MfaType>());
    });

    test('test method createMFAAuthenticator()', () async {
      final Map<String, dynamic> data = {
        'secret': "[SHARED_SECRET]",
        'uri':
            "otpauth://totp/appwrite:user@example.com?secret=[SHARED_SECRET]&issuer=appwrite",
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

      final response = await account.createMFAAuthenticator(
        type: enums.AuthenticatorType.totp,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/mfa/authenticators/totp",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.MfaType>());
    });

    test('test method updateMfaAuthenticator()', () async {
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
        client.call(
          HttpMethod.put,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMfaAuthenticator(
        type: enums.AuthenticatorType.totp,
        otp: "<OTP>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/mfa/authenticators/totp",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["otp"]));
      expect(response, isA<models.User>());
    });

    test('test method updateMFAAuthenticator()', () async {
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
        client.call(
          HttpMethod.put,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMFAAuthenticator(
        type: enums.AuthenticatorType.totp,
        otp: "<OTP>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/mfa/authenticators/totp",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["otp"]));
      expect(response, isA<models.User>());
    });

    test('test method deleteMfaAuthenticator()', () async {
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

      final response = await account.deleteMfaAuthenticator(
        type: enums.AuthenticatorType.totp,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/account/mfa/authenticators/totp",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
    });

    test('test method deleteMFAAuthenticator()', () async {
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

      final response = await account.deleteMFAAuthenticator(
        type: enums.AuthenticatorType.totp,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/account/mfa/authenticators/totp",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
    });

    test('test method createMfaChallenge()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'expire': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.createMfaChallenge(
        factor: enums.AuthenticationFactor.email,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/mfa/challenges",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["factor"]));
      expect(response, isA<models.MfaChallenge>());
    });

    test('test method createMFAChallenge()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'expire': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.createMFAChallenge(
        factor: enums.AuthenticationFactor.email,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/mfa/challenges",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["factor"]));
      expect(response, isA<models.MfaChallenge>());
    });

    test('test method updateMfaChallenge()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5bb8c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'provider': "email",
        'providerUid': "user@example.com",
        'providerAccessToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'providerAccessTokenExpiry': "2020-10-15T06:38:00.000+00:00",
        'providerRefreshToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'ip': "127.0.0.1",
        'osCode': "Mac",
        'osName': "Mac",
        'osVersion': "Mac",
        'clientType': "browser",
        'clientCode': "CM",
        'clientName': "Chrome Mobile iOS",
        'clientVersion': "84.0",
        'clientEngine': "WebKit",
        'clientEngineVersion': "605.1.15",
        'deviceName': "smartphone",
        'deviceBrand': "Google",
        'deviceModel': "Nexus 5",
        'countryCode': "US",
        'countryName': "United States",
        'current': true,
        'factors': [],
        'secret': "5e5bb8c16897e",
        'mfaUpdatedAt': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.updateMfaChallenge(
        challengeId: "<CHALLENGE_ID>",
        otp: "<OTP>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/mfa/challenges",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["challengeId", "otp"]));
      expect(response, isA<models.Session>());
    });

    test('test method updateMFAChallenge()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5bb8c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'provider': "email",
        'providerUid': "user@example.com",
        'providerAccessToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'providerAccessTokenExpiry': "2020-10-15T06:38:00.000+00:00",
        'providerRefreshToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'ip': "127.0.0.1",
        'osCode': "Mac",
        'osName': "Mac",
        'osVersion': "Mac",
        'clientType': "browser",
        'clientCode': "CM",
        'clientName': "Chrome Mobile iOS",
        'clientVersion': "84.0",
        'clientEngine': "WebKit",
        'clientEngineVersion': "605.1.15",
        'deviceName': "smartphone",
        'deviceBrand': "Google",
        'deviceModel': "Nexus 5",
        'countryCode': "US",
        'countryName': "United States",
        'current': true,
        'factors': [],
        'secret': "5e5bb8c16897e",
        'mfaUpdatedAt': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.updateMFAChallenge(
        challengeId: "<CHALLENGE_ID>",
        otp: "<OTP>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/mfa/challenges",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["challengeId", "otp"]));
      expect(response, isA<models.Session>());
    });

    test('test method listMfaFactors()', () async {
      final Map<String, dynamic> data = {
        'totp': true,
        'phone': true,
        'email': true,
        'recoveryCode': true,
        'custom': true,
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

      final response = await account.listMfaFactors();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/mfa/factors",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.MfaFactors>());
    });

    test('test method listMFAFactors()', () async {
      final Map<String, dynamic> data = {
        'totp': true,
        'phone': true,
        'email': true,
        'recoveryCode': true,
        'custom': true,
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

      final response = await account.listMFAFactors();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/mfa/factors",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.MfaFactors>());
    });

    test('test method getMfaRecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
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

      final response = await account.getMfaRecoveryCodes();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/mfa/recovery-codes",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method getMFARecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
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

      final response = await account.getMFARecoveryCodes();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/mfa/recovery-codes",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method createMfaRecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
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

      final response = await account.createMfaRecoveryCodes();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/mfa/recovery-codes",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method createMFARecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
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

      final response = await account.createMFARecoveryCodes();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/mfa/recovery-codes",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method updateMfaRecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
      };

      when(
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMfaRecoveryCodes();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/account/mfa/recovery-codes",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method updateMFARecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
      };

      when(
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMFARecoveryCodes();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/account/mfa/recovery-codes",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method updateName()', () async {
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
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updateName(
        name: "<NAME>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/account/name",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["name"]));
      expect(response, isA<models.User>());
    });

    test('test method listPasskeys()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'passkeys': [],
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

      final response = await account.listPasskeys();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/passkeys",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.PasskeyList>());
    });

    test('test method createPasskey()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'passkeyId': "5e5ea5c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'publicKey': <String, dynamic>{},
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

      final response = await account.createPasskey();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/passkeys",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.PasskeyChallenge>());
    });

    test('test method getPasskey()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "My laptop",
        'accessedAt': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.getPasskey(
        passkeyId: "<PASSKEY_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/passkeys/<PASSKEY_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Passkey>());
    });

    test('test method updatePasskey()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "My laptop",
        'accessedAt': "2020-10-15T06:38:00.000+00:00",
      };

      when(
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePasskey(
        passkeyId: "<PASSKEY_ID>",
        name: "<NAME>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/account/passkeys/<PASSKEY_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["name"]));
      expect(response, isA<models.Passkey>());
    });

    test('test method deletePasskey()', () async {
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

      final response = await account.deletePasskey(
        passkeyId: "<PASSKEY_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/account/passkeys/<PASSKEY_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
    });

    test('test method updatePasskeyVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "My laptop",
        'accessedAt': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.updatePasskeyVerification(
        passkeyId: "<PASSKEY_ID>",
        credential: {},
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/passkeys/<PASSKEY_ID>/verification",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["credential"]));
      expect(response, isA<models.Passkey>());
    });

    test('test method updatePassword()', () async {
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
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePassword(
        password: "password",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/account/password",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["password"]));
      expect(response, isA<models.User>());
    });

    test('test method updatePhone()', () async {
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
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePhone(
        phone: "+12065550100",
        password: "password",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/account/phone",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["phone", "password"]));
      expect(response, isA<models.User>());
    });

    test('test method getPrefs()', () async {
      final Map<String, dynamic> data = {};

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.getPrefs();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/prefs",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Preferences>());
    });

    test('test method updatePrefs()', () async {
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
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePrefs(
        prefs: {},
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/account/prefs",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["prefs"]));
      expect(response, isA<models.User>());
    });

    test('test method createRecovery()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.createRecovery(
        email: "email@example.com",
        url: "https://example.com",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/recovery",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["email", "url"]));
      expect(response, isA<models.Token>());
    });

    test('test method updateRecovery()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.updateRecovery(
        userId: "<USER_ID>",
        secret: "<SECRET>",
        password: "password",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/recovery",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "secret", "password"]));
      expect(response, isA<models.Token>());
    });

    test('test method createRecoveryOTP()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.createRecoveryOTP(
        email: "email@example.com",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/recovery/otp",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["email"]));
      expect(response, isA<models.Token>());
    });

    test('test method updateRecoveryOTP()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.updateRecoveryOTP(
        userId: "<USER_ID>",
        secret: "<SECRET>",
        password: "password",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/recovery/otp",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "secret", "password"]));
      expect(response, isA<models.Token>());
    });

    test('test method listSessions()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'sessions': [],
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

      final response = await account.listSessions();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/sessions",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.SessionList>());
    });

    test('test method deleteSessions()', () async {
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

      final response = await account.deleteSessions();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/account/sessions",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
    });

    test('test method createAnonymousSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5bb8c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'provider': "email",
        'providerUid': "user@example.com",
        'providerAccessToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'providerAccessTokenExpiry': "2020-10-15T06:38:00.000+00:00",
        'providerRefreshToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'ip': "127.0.0.1",
        'osCode': "Mac",
        'osName': "Mac",
        'osVersion': "Mac",
        'clientType': "browser",
        'clientCode': "CM",
        'clientName': "Chrome Mobile iOS",
        'clientVersion': "84.0",
        'clientEngine': "WebKit",
        'clientEngineVersion': "605.1.15",
        'deviceName': "smartphone",
        'deviceBrand': "Google",
        'deviceModel': "Nexus 5",
        'countryCode': "US",
        'countryName': "United States",
        'current': true,
        'factors': [],
        'secret': "5e5bb8c16897e",
        'mfaUpdatedAt': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.createAnonymousSession();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/sessions/anonymous",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Session>());
    });

    test('test method createEmailPasswordSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5bb8c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'provider': "email",
        'providerUid': "user@example.com",
        'providerAccessToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'providerAccessTokenExpiry': "2020-10-15T06:38:00.000+00:00",
        'providerRefreshToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'ip': "127.0.0.1",
        'osCode': "Mac",
        'osName': "Mac",
        'osVersion': "Mac",
        'clientType': "browser",
        'clientCode': "CM",
        'clientName': "Chrome Mobile iOS",
        'clientVersion': "84.0",
        'clientEngine': "WebKit",
        'clientEngineVersion': "605.1.15",
        'deviceName': "smartphone",
        'deviceBrand': "Google",
        'deviceModel': "Nexus 5",
        'countryCode': "US",
        'countryName': "United States",
        'current': true,
        'factors': [],
        'secret': "5e5bb8c16897e",
        'mfaUpdatedAt': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.createEmailPasswordSession(
        email: "email@example.com",
        password: "password",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/sessions/email",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["email", "password"]));
      expect(response, isA<models.Session>());
    });

    test('test method createIdTokenSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5bb8c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'provider': "email",
        'providerUid': "user@example.com",
        'providerAccessToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'providerAccessTokenExpiry': "2020-10-15T06:38:00.000+00:00",
        'providerRefreshToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'ip': "127.0.0.1",
        'osCode': "Mac",
        'osName': "Mac",
        'osVersion': "Mac",
        'clientType': "browser",
        'clientCode': "CM",
        'clientName': "Chrome Mobile iOS",
        'clientVersion': "84.0",
        'clientEngine': "WebKit",
        'clientEngineVersion': "605.1.15",
        'deviceName': "smartphone",
        'deviceBrand': "Google",
        'deviceModel': "Nexus 5",
        'countryCode': "US",
        'countryName': "United States",
        'current': true,
        'factors': [],
        'secret': "5e5bb8c16897e",
        'mfaUpdatedAt': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.createIdTokenSession(
        provider: enums.IdTokenProvider.apple,
        idToken: "<ID_TOKEN>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/sessions/id-token",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["provider", "idToken"]));
      expect(response, isA<models.Session>());
    });

    test('test method updateMagicURLSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5bb8c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'provider': "email",
        'providerUid': "user@example.com",
        'providerAccessToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'providerAccessTokenExpiry': "2020-10-15T06:38:00.000+00:00",
        'providerRefreshToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'ip': "127.0.0.1",
        'osCode': "Mac",
        'osName': "Mac",
        'osVersion': "Mac",
        'clientType': "browser",
        'clientCode': "CM",
        'clientName': "Chrome Mobile iOS",
        'clientVersion': "84.0",
        'clientEngine': "WebKit",
        'clientEngineVersion': "605.1.15",
        'deviceName': "smartphone",
        'deviceBrand': "Google",
        'deviceModel': "Nexus 5",
        'countryCode': "US",
        'countryName': "United States",
        'current': true,
        'factors': [],
        'secret': "5e5bb8c16897e",
        'mfaUpdatedAt': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.updateMagicURLSession(
        userId: "<USER_ID>",
        secret: "<SECRET>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/sessions/magic-url",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "secret"]));
      expect(response, isA<models.Session>());
    });

    test('test method createOAuth2Session()', () async {
      final data = '';

      when(client.webAuth(argThat(isNotNull))).thenAnswer((_) async => 'done');

      final response = await account.createOAuth2Session(
        provider: enums.OAuthProvider.amazon,
      );
      final Uri url = verify(client.webAuth(captureAny)).captured.single;
      expect(Uri.decodeFull(url.path), "/v1/account/sessions/oauth2/amazon");
      expect(response, equals('done'));
    });

    test('test method updatePhoneSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5bb8c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'provider': "email",
        'providerUid': "user@example.com",
        'providerAccessToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'providerAccessTokenExpiry': "2020-10-15T06:38:00.000+00:00",
        'providerRefreshToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'ip': "127.0.0.1",
        'osCode': "Mac",
        'osName': "Mac",
        'osVersion': "Mac",
        'clientType': "browser",
        'clientCode': "CM",
        'clientName': "Chrome Mobile iOS",
        'clientVersion': "84.0",
        'clientEngine': "WebKit",
        'clientEngineVersion': "605.1.15",
        'deviceName': "smartphone",
        'deviceBrand': "Google",
        'deviceModel': "Nexus 5",
        'countryCode': "US",
        'countryName': "United States",
        'current': true,
        'factors': [],
        'secret': "5e5bb8c16897e",
        'mfaUpdatedAt': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.updatePhoneSession(
        userId: "<USER_ID>",
        secret: "<SECRET>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/sessions/phone",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "secret"]));
      expect(response, isA<models.Session>());
    });

    test('test method createSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5bb8c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'provider': "email",
        'providerUid': "user@example.com",
        'providerAccessToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'providerAccessTokenExpiry': "2020-10-15T06:38:00.000+00:00",
        'providerRefreshToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'ip': "127.0.0.1",
        'osCode': "Mac",
        'osName': "Mac",
        'osVersion': "Mac",
        'clientType': "browser",
        'clientCode': "CM",
        'clientName': "Chrome Mobile iOS",
        'clientVersion': "84.0",
        'clientEngine': "WebKit",
        'clientEngineVersion': "605.1.15",
        'deviceName': "smartphone",
        'deviceBrand': "Google",
        'deviceModel': "Nexus 5",
        'countryCode': "US",
        'countryName': "United States",
        'current': true,
        'factors': [],
        'secret': "5e5bb8c16897e",
        'mfaUpdatedAt': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.createSession(
        userId: "<USER_ID>",
        secret: "<SECRET>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/sessions/token",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "secret"]));
      expect(response, isA<models.Session>());
    });

    test('test method getSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5bb8c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'provider': "email",
        'providerUid': "user@example.com",
        'providerAccessToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'providerAccessTokenExpiry': "2020-10-15T06:38:00.000+00:00",
        'providerRefreshToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'ip': "127.0.0.1",
        'osCode': "Mac",
        'osName': "Mac",
        'osVersion': "Mac",
        'clientType': "browser",
        'clientCode': "CM",
        'clientName': "Chrome Mobile iOS",
        'clientVersion': "84.0",
        'clientEngine': "WebKit",
        'clientEngineVersion': "605.1.15",
        'deviceName': "smartphone",
        'deviceBrand': "Google",
        'deviceModel': "Nexus 5",
        'countryCode': "US",
        'countryName': "United States",
        'current': true,
        'factors': [],
        'secret': "5e5bb8c16897e",
        'mfaUpdatedAt': "2020-10-15T06:38:00.000+00:00",
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

      final response = await account.getSession(
        sessionId: "<SESSION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/account/sessions/<SESSION_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Session>());
    });

    test('test method updateSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5bb8c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'provider': "email",
        'providerUid': "user@example.com",
        'providerAccessToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'providerAccessTokenExpiry': "2020-10-15T06:38:00.000+00:00",
        'providerRefreshToken': "MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3",
        'ip': "127.0.0.1",
        'osCode': "Mac",
        'osName': "Mac",
        'osVersion': "Mac",
        'clientType': "browser",
        'clientCode': "CM",
        'clientName': "Chrome Mobile iOS",
        'clientVersion': "84.0",
        'clientEngine': "WebKit",
        'clientEngineVersion': "605.1.15",
        'deviceName': "smartphone",
        'deviceBrand': "Google",
        'deviceModel': "Nexus 5",
        'countryCode': "US",
        'countryName': "United States",
        'current': true,
        'factors': [],
        'secret': "5e5bb8c16897e",
        'mfaUpdatedAt': "2020-10-15T06:38:00.000+00:00",
      };

      when(
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updateSession(
        sessionId: "<SESSION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/account/sessions/<SESSION_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Session>());
    });

    test('test method deleteSession()', () async {
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

      final response = await account.deleteSession(
        sessionId: "<SESSION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/account/sessions/<SESSION_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
    });

    test('test method updateStatus()', () async {
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
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await account.updateStatus();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/account/status",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.User>());
    });

    test('test method createPushTarget()', () async {
      final Map<String, dynamic> data = {
        '\$id': "259125845563242502",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "Apple iPhone 12",
        'userId': "259125845563242502",
        'providerType': "email",
        'identifier': "token",
        'expired': true,
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

      final response = await account.createPushTarget(
        targetId: "<TARGET_ID>",
        identifier: "<IDENTIFIER>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/targets/push",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["targetId", "identifier"]));
      expect(response, isA<models.Target>());
    });

    test('test method updatePushTarget()', () async {
      final Map<String, dynamic> data = {
        '\$id': "259125845563242502",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "Apple iPhone 12",
        'userId': "259125845563242502",
        'providerType': "email",
        'identifier': "token",
        'expired': true,
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

      final response = await account.updatePushTarget(
        targetId: "<TARGET_ID>",
        identifier: "<IDENTIFIER>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/targets/<TARGET_ID>/push",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["identifier"]));
      expect(response, isA<models.Target>());
    });

    test('test method deletePushTarget()', () async {
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

      final response = await account.deletePushTarget(
        targetId: "<TARGET_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/account/targets/<TARGET_ID>/push",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
    });

    test('test method createEmailToken()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.createEmailToken(
        userId: "<USER_ID>",
        email: "email@example.com",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/tokens/email",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "email"]));
      expect(response, isA<models.Token>());
    });

    test('test method createMagicURLToken()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.createMagicURLToken(
        userId: "<USER_ID>",
        email: "email@example.com",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/tokens/magic-url",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "email"]));
      expect(response, isA<models.Token>());
    });

    test('test method createOAuth2Token()', () async {
      final data = '';

      when(client.webAuth(argThat(isNotNull))).thenAnswer((_) async => 'done');

      final response = await account.createOAuth2Token(
        provider: enums.OAuthProvider.amazon,
      );
      final Uri url = verify(client.webAuth(captureAny)).captured.single;
      expect(Uri.decodeFull(url.path), "/v1/account/tokens/oauth2/amazon");
      expect(response, equals('done'));
    });

    test('test method createPasskeyToken()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'passkeyId': "5e5ea5c16897e",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'publicKey': <String, dynamic>{},
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

      final response = await account.createPasskeyToken();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/tokens/passkey",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.PasskeyChallenge>());
    });

    test('test method updatePasskeyToken()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.updatePasskeyToken(
        challengeId: "<CHALLENGE_ID>",
        credential: {},
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/tokens/passkey",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["challengeId", "credential"]));
      expect(response, isA<models.TokenSecret>());
    });

    test('test method createPhoneToken()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.createPhoneToken(
        userId: "<USER_ID>",
        phone: "+12065550100",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/tokens/phone",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "phone"]));
      expect(response, isA<models.Token>());
    });

    test('test method createEmailVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.createEmailVerification(
        url: "https://example.com",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/verifications/email",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["url"]));
      expect(response, isA<models.Token>());
    });

    test('test method createVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.createVerification(
        url: "https://example.com",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/verifications/email",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["url"]));
      expect(response, isA<models.Token>());
    });

    test('test method updateEmailVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.updateEmailVerification(
        userId: "<USER_ID>",
        secret: "<SECRET>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/verifications/email",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "secret"]));
      expect(response, isA<models.Token>());
    });

    test('test method updateVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.updateVerification(
        userId: "<USER_ID>",
        secret: "<SECRET>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/verifications/email",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "secret"]));
      expect(response, isA<models.Token>());
    });

    test('test method createEmailVerificationOTP()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.createEmailVerificationOTP();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/verifications/email/otp",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Token>());
    });

    test('test method updateEmailVerificationOTP()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.updateEmailVerificationOTP(
        userId: "<USER_ID>",
        secret: "<SECRET>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/verifications/email/otp",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "secret"]));
      expect(response, isA<models.Token>());
    });

    test('test method createPhoneVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.createPhoneVerification();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/account/verifications/phone",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Token>());
    });

    test('test method updatePhoneVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': "bb8ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c168bb8",
        'secret': "",
        'expire': "2020-10-15T06:38:00.000+00:00",
        'phrase': "Golden Fox",
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

      final response = await account.updatePhoneVerification(
        userId: "<USER_ID>",
        secret: "<SECRET>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/account/verifications/phone",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["userId", "secret"]));
      expect(response, isA<models.Token>());
    });
  });
}
