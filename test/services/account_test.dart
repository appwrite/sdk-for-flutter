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
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.get();
      expect(response, isA<models.User>());
    });

    test('test method create()', () async {
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
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.create(
        userId: '<USER_ID>',
        email: 'email@example.com',
        password: '',
      );
      expect(response, isA<models.User>());
    });

    test('test method listBillingAddresses()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'billingAddresses': [],
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.listBillingAddresses();
      expect(response, isA<models.BillingAddressList>());
    });

    test('test method createBillingAddress()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'eu-fr',
        'userId': '5e5ea5c16897e',
        'streetAddress': '13th Avenue',
        'addressLine2': '',
        'country': 'USA',
        'city': '',
        'state': '',
        'postalCode': '',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createBillingAddress(
        country: '<COUNTRY>',
        city: '<CITY>',
        streetAddress: '<STREET_ADDRESS>',
      );
      expect(response, isA<models.BillingAddress>());
    });

    test('test method getBillingAddress()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'eu-fr',
        'userId': '5e5ea5c16897e',
        'streetAddress': '13th Avenue',
        'addressLine2': '',
        'country': 'USA',
        'city': '',
        'state': '',
        'postalCode': '',
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.getBillingAddress(
        billingAddressId: '<BILLING_ADDRESS_ID>',
      );
      expect(response, isA<models.BillingAddress>());
    });

    test('test method updateBillingAddress()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'eu-fr',
        'userId': '5e5ea5c16897e',
        'streetAddress': '13th Avenue',
        'addressLine2': '',
        'country': 'USA',
        'city': '',
        'state': '',
        'postalCode': '',
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateBillingAddress(
        billingAddressId: '<BILLING_ADDRESS_ID>',
        country: '<COUNTRY>',
        city: '<CITY>',
        streetAddress: '<STREET_ADDRESS>',
      );
      expect(response, isA<models.BillingAddress>());
    });

    test('test method deleteBillingAddress()', () async {
      final data = '';

      when(client.call(
        HttpMethod.delete,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.deleteBillingAddress(
        billingAddressId: '<BILLING_ADDRESS_ID>',
      );
    });

    test('test method updateEmail()', () async {
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
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateEmail(
        email: 'email@example.com',
        password: 'password',
      );
      expect(response, isA<models.User>());
    });

    test('test method listIdentities()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'identities': [],
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.listIdentities();
      expect(response, isA<models.IdentityList>());
    });

    test('test method deleteIdentity()', () async {
      final data = '';

      when(client.call(
        HttpMethod.delete,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.deleteIdentity(
        identityId: '<IDENTITY_ID>',
      );
    });

    test('test method createJWT()', () async {
      final Map<String, dynamic> data = {
        'jwt':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createJWT();
      expect(response, isA<models.Jwt>());
    });

    test('test method listKeys()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'keys': [],
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.listKeys();
      expect(response, isA<models.KeyList>());
    });

    test('test method createKey()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'name': 'My API Key',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'scopes': [],
        'secret': '919c2d18fb5d4...a2ae413da83346ad2',
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
        'sdks': [],
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createKey(
        name: '<NAME>',
        scopes: [enums.Scopes.account],
      );
      expect(response, isA<models.Key>());
    });

    test('test method getKey()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'name': 'My API Key',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'scopes': [],
        'secret': '919c2d18fb5d4...a2ae413da83346ad2',
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
        'sdks': [],
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.getKey(
        keyId: '<KEY_ID>',
      );
      expect(response, isA<models.Key>());
    });

    test('test method updateKey()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'name': 'My API Key',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'scopes': [],
        'secret': '919c2d18fb5d4...a2ae413da83346ad2',
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
        'sdks': [],
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateKey(
        keyId: '<KEY_ID>',
        name: '<NAME>',
        scopes: [enums.Scopes.account],
      );
      expect(response, isA<models.Key>());
    });

    test('test method deleteKey()', () async {
      final data = '';

      when(client.call(
        HttpMethod.delete,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.deleteKey(
        keyId: '<KEY_ID>',
      );
    });

    test('test method listLogs()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'logs': [],
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.listLogs();
      expect(response, isA<models.LogList>());
    });

    test('test method updateMFA()', () async {
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
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMFA(
        mfa: true,
      );
      expect(response, isA<models.User>());
    });

    test('test method createMfaAuthenticator()', () async {
      final Map<String, dynamic> data = {
        'secret': '1',
        'uri': '1',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createMfaAuthenticator(
        type: enums.AuthenticatorType.totp,
      );
      expect(response, isA<models.MfaType>());
    });

    test('test method createMFAAuthenticator()', () async {
      final Map<String, dynamic> data = {
        'secret': '1',
        'uri': '1',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createMFAAuthenticator(
        type: enums.AuthenticatorType.totp,
      );
      expect(response, isA<models.MfaType>());
    });

    test('test method updateMfaAuthenticator()', () async {
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
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMfaAuthenticator(
        type: enums.AuthenticatorType.totp,
        otp: '<OTP>',
      );
      expect(response, isA<models.User>());
    });

    test('test method updateMFAAuthenticator()', () async {
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
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMFAAuthenticator(
        type: enums.AuthenticatorType.totp,
        otp: '<OTP>',
      );
      expect(response, isA<models.User>());
    });

    test('test method deleteMfaAuthenticator()', () async {
      final data = '';

      when(client.call(
        HttpMethod.delete,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.deleteMfaAuthenticator(
        type: enums.AuthenticatorType.totp,
      );
    });

    test('test method deleteMFAAuthenticator()', () async {
      final data = '';

      when(client.call(
        HttpMethod.delete,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.deleteMFAAuthenticator(
        type: enums.AuthenticatorType.totp,
      );
    });

    test('test method createMfaChallenge()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'bb8ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'expire': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createMfaChallenge(
        factor: enums.AuthenticationFactor.email,
      );
      expect(response, isA<models.MfaChallenge>());
    });

    test('test method createMFAChallenge()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'bb8ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'expire': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createMFAChallenge(
        factor: enums.AuthenticationFactor.email,
      );
      expect(response, isA<models.MfaChallenge>());
    });

    test('test method updateMfaChallenge()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5bb8c16897e',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'provider': 'email',
        'providerUid': 'user@example.com',
        'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        'providerAccessTokenExpiry': '2020-10-15T06:38:00.000+00:00',
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
        'current': true,
        'factors': [],
        'secret': '5e5bb8c16897e',
        'mfaUpdatedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMfaChallenge(
        challengeId: '<CHALLENGE_ID>',
        otp: '<OTP>',
      );
      expect(response, isA<models.Session>());
    });

    test('test method updateMFAChallenge()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5bb8c16897e',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'provider': 'email',
        'providerUid': 'user@example.com',
        'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        'providerAccessTokenExpiry': '2020-10-15T06:38:00.000+00:00',
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
        'current': true,
        'factors': [],
        'secret': '5e5bb8c16897e',
        'mfaUpdatedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMFAChallenge(
        challengeId: '<CHALLENGE_ID>',
        otp: '<OTP>',
      );
      expect(response, isA<models.Session>());
    });

    test('test method listMfaFactors()', () async {
      final Map<String, dynamic> data = {
        'totp': true,
        'phone': true,
        'email': true,
        'recoveryCode': true,
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.listMfaFactors();
      expect(response, isA<models.MfaFactors>());
    });

    test('test method listMFAFactors()', () async {
      final Map<String, dynamic> data = {
        'totp': true,
        'phone': true,
        'email': true,
        'recoveryCode': true,
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.listMFAFactors();
      expect(response, isA<models.MfaFactors>());
    });

    test('test method getMfaRecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.getMfaRecoveryCodes();
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method getMFARecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.getMFARecoveryCodes();
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method createMfaRecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createMfaRecoveryCodes();
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method createMFARecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createMFARecoveryCodes();
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method updateMfaRecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMfaRecoveryCodes();
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method updateMFARecoveryCodes()', () async {
      final Map<String, dynamic> data = {
        'recoveryCodes': [],
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMFARecoveryCodes();
      expect(response, isA<models.MfaRecoveryCodes>());
    });

    test('test method updateName()', () async {
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
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateName(
        name: '<NAME>',
      );
      expect(response, isA<models.User>());
    });

    test('test method updatePassword()', () async {
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
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePassword(
        password: '',
      );
      expect(response, isA<models.User>());
    });

    test('test method listPaymentMethods()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'paymentMethods': [],
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.listPaymentMethods();
      expect(response, isA<models.PaymentMethodList>());
    });

    test('test method createPaymentMethod()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        '\$permissions': [],
        'providerMethodId': 'abdk3ed3sdkfj',
        'clientSecret': 'seti_ddfe',
        'providerUserId': 'abdk3ed3sdkfj',
        'userId': '5e5ea5c16897e',
        'expiryMonth': 2,
        'expiryYear': 2024,
        'last4': '4242',
        'brand': 'visa',
        'name': 'John Doe',
        'mandateId': 'yxc',
        'country': 'de',
        'state': '',
        'lastError': 'Your card has insufficient funds.',
        'default': true,
        'expired': true,
        'failed': true,
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createPaymentMethod();
      expect(response, isA<models.PaymentMethod>());
    });

    test('test method getPaymentMethod()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        '\$permissions': [],
        'providerMethodId': 'abdk3ed3sdkfj',
        'clientSecret': 'seti_ddfe',
        'providerUserId': 'abdk3ed3sdkfj',
        'userId': '5e5ea5c16897e',
        'expiryMonth': 2,
        'expiryYear': 2024,
        'last4': '4242',
        'brand': 'visa',
        'name': 'John Doe',
        'mandateId': 'yxc',
        'country': 'de',
        'state': '',
        'lastError': 'Your card has insufficient funds.',
        'default': true,
        'expired': true,
        'failed': true,
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.getPaymentMethod(
        paymentMethodId: '<PAYMENT_METHOD_ID>',
      );
      expect(response, isA<models.PaymentMethod>());
    });

    test('test method updatePaymentMethod()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        '\$permissions': [],
        'providerMethodId': 'abdk3ed3sdkfj',
        'clientSecret': 'seti_ddfe',
        'providerUserId': 'abdk3ed3sdkfj',
        'userId': '5e5ea5c16897e',
        'expiryMonth': 2,
        'expiryYear': 2024,
        'last4': '4242',
        'brand': 'visa',
        'name': 'John Doe',
        'mandateId': 'yxc',
        'country': 'de',
        'state': '',
        'lastError': 'Your card has insufficient funds.',
        'default': true,
        'expired': true,
        'failed': true,
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePaymentMethod(
        paymentMethodId: '<PAYMENT_METHOD_ID>',
        expiryMonth: 1,
        expiryYear: 1,
      );
      expect(response, isA<models.PaymentMethod>());
    });

    test('test method deletePaymentMethod()', () async {
      final data = '';

      when(client.call(
        HttpMethod.delete,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.deletePaymentMethod(
        paymentMethodId: '<PAYMENT_METHOD_ID>',
      );
    });

    test('test method updatePaymentMethodProvider()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        '\$permissions': [],
        'providerMethodId': 'abdk3ed3sdkfj',
        'clientSecret': 'seti_ddfe',
        'providerUserId': 'abdk3ed3sdkfj',
        'userId': '5e5ea5c16897e',
        'expiryMonth': 2,
        'expiryYear': 2024,
        'last4': '4242',
        'brand': 'visa',
        'name': 'John Doe',
        'mandateId': 'yxc',
        'country': 'de',
        'state': '',
        'lastError': 'Your card has insufficient funds.',
        'default': true,
        'expired': true,
        'failed': true,
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePaymentMethodProvider(
        paymentMethodId: '<PAYMENT_METHOD_ID>',
        providerMethodId: '<PROVIDER_METHOD_ID>',
        name: '<NAME>',
      );
      expect(response, isA<models.PaymentMethod>());
    });

    test('test method updatePaymentMethodMandateOptions()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        '\$permissions': [],
        'providerMethodId': 'abdk3ed3sdkfj',
        'clientSecret': 'seti_ddfe',
        'providerUserId': 'abdk3ed3sdkfj',
        'userId': '5e5ea5c16897e',
        'expiryMonth': 2,
        'expiryYear': 2024,
        'last4': '4242',
        'brand': 'visa',
        'name': 'John Doe',
        'mandateId': 'yxc',
        'country': 'de',
        'state': '',
        'lastError': 'Your card has insufficient funds.',
        'default': true,
        'expired': true,
        'failed': true,
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePaymentMethodMandateOptions(
        paymentMethodId: '<PAYMENT_METHOD_ID>',
      );
      expect(response, isA<models.PaymentMethod>());
    });

    test('test method updatePhone()', () async {
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
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePhone(
        phone: '+12065550100',
        password: 'password',
      );
      expect(response, isA<models.User>());
    });

    test('test method getPrefs()', () async {
      final Map<String, dynamic> data = {};

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.getPrefs();
      expect(response, isA<models.Preferences>());
    });

    test('test method updatePrefs()', () async {
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
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
      };

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
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'secret': '',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'phrase': 'Golden Fox',
      };

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
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'secret': '',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'phrase': 'Golden Fox',
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateRecovery(
        userId: '<USER_ID>',
        secret: '<SECRET>',
        password: '',
      );
      expect(response, isA<models.Token>());
    });

    test('test method listSessions()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'sessions': [],
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.listSessions();
      expect(response, isA<models.SessionList>());
    });

    test('test method deleteSessions()', () async {
      final data = '';

      when(client.call(
        HttpMethod.delete,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.deleteSessions();
    });

    test('test method createAnonymousSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5bb8c16897e',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'provider': 'email',
        'providerUid': 'user@example.com',
        'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        'providerAccessTokenExpiry': '2020-10-15T06:38:00.000+00:00',
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
        'current': true,
        'factors': [],
        'secret': '5e5bb8c16897e',
        'mfaUpdatedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createAnonymousSession();
      expect(response, isA<models.Session>());
    });

    test('test method createEmailPasswordSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5bb8c16897e',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'provider': 'email',
        'providerUid': 'user@example.com',
        'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        'providerAccessTokenExpiry': '2020-10-15T06:38:00.000+00:00',
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
        'current': true,
        'factors': [],
        'secret': '5e5bb8c16897e',
        'mfaUpdatedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createEmailPasswordSession(
        email: 'email@example.com',
        password: 'password',
      );
      expect(response, isA<models.Session>());
    });

    test('test method updateMagicURLSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5bb8c16897e',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'provider': 'email',
        'providerUid': 'user@example.com',
        'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        'providerAccessTokenExpiry': '2020-10-15T06:38:00.000+00:00',
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
        'current': true,
        'factors': [],
        'secret': '5e5bb8c16897e',
        'mfaUpdatedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateMagicURLSession(
        userId: '<USER_ID>',
        secret: '<SECRET>',
      );
      expect(response, isA<models.Session>());
    });

    test('test method createOAuth2Session()', () async {
      when(client.webAuth(
        Uri(),
      )).thenAnswer((_) async => 'done');

      final response = await account.createOAuth2Session(
        provider: enums.OAuthProvider.amazon,
      );
    });

    test('test method updatePhoneSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5bb8c16897e',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'provider': 'email',
        'providerUid': 'user@example.com',
        'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        'providerAccessTokenExpiry': '2020-10-15T06:38:00.000+00:00',
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
        'current': true,
        'factors': [],
        'secret': '5e5bb8c16897e',
        'mfaUpdatedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePhoneSession(
        userId: '<USER_ID>',
        secret: '<SECRET>',
      );
      expect(response, isA<models.Session>());
    });

    test('test method createSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5bb8c16897e',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'provider': 'email',
        'providerUid': 'user@example.com',
        'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        'providerAccessTokenExpiry': '2020-10-15T06:38:00.000+00:00',
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
        'current': true,
        'factors': [],
        'secret': '5e5bb8c16897e',
        'mfaUpdatedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createSession(
        userId: '<USER_ID>',
        secret: '<SECRET>',
      );
      expect(response, isA<models.Session>());
    });

    test('test method getSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5bb8c16897e',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'provider': 'email',
        'providerUid': 'user@example.com',
        'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        'providerAccessTokenExpiry': '2020-10-15T06:38:00.000+00:00',
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
        'current': true,
        'factors': [],
        'secret': '5e5bb8c16897e',
        'mfaUpdatedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.get,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.getSession(
        sessionId: '<SESSION_ID>',
      );
      expect(response, isA<models.Session>());
    });

    test('test method updateSession()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5bb8c16897e',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'provider': 'email',
        'providerUid': 'user@example.com',
        'providerAccessToken': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        'providerAccessTokenExpiry': '2020-10-15T06:38:00.000+00:00',
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
        'current': true,
        'factors': [],
        'secret': '5e5bb8c16897e',
        'mfaUpdatedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateSession(
        sessionId: '<SESSION_ID>',
      );
      expect(response, isA<models.Session>());
    });

    test('test method deleteSession()', () async {
      final data = '';

      when(client.call(
        HttpMethod.delete,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.deleteSession(
        sessionId: '<SESSION_ID>',
      );
    });

    test('test method updateStatus()', () async {
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
        'prefs': <String, dynamic>{},
        'targets': [],
        'accessedAt': '2020-10-15T06:38:00.000+00:00',
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateStatus();
      expect(response, isA<models.User>());
    });

    test('test method createPushTarget()', () async {
      final Map<String, dynamic> data = {
        '\$id': '259125845563242502',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'name': 'Apple iPhone 12',
        'userId': '259125845563242502',
        'providerType': 'email',
        'identifier': 'token',
        'expired': true,
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createPushTarget(
        targetId: '<TARGET_ID>',
        identifier: '<IDENTIFIER>',
      );
      expect(response, isA<models.Target>());
    });

    test('test method updatePushTarget()', () async {
      final Map<String, dynamic> data = {
        '\$id': '259125845563242502',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'name': 'Apple iPhone 12',
        'userId': '259125845563242502',
        'providerType': 'email',
        'identifier': 'token',
        'expired': true,
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePushTarget(
        targetId: '<TARGET_ID>',
        identifier: '<IDENTIFIER>',
      );
      expect(response, isA<models.Target>());
    });

    test('test method deletePushTarget()', () async {
      final data = '';

      when(client.call(
        HttpMethod.delete,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.deletePushTarget(
        targetId: '<TARGET_ID>',
      );
    });

    test('test method createEmailToken()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'bb8ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'secret': '',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'phrase': 'Golden Fox',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createEmailToken(
        userId: '<USER_ID>',
        email: 'email@example.com',
      );
      expect(response, isA<models.Token>());
    });

    test('test method createMagicURLToken()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'bb8ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'secret': '',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'phrase': 'Golden Fox',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createMagicURLToken(
        userId: '<USER_ID>',
        email: 'email@example.com',
      );
      expect(response, isA<models.Token>());
    });

    test('test method createOAuth2Token()', () async {
      when(client.webAuth(
        Uri(),
      )).thenAnswer((_) async => 'done');

      final response = await account.createOAuth2Token(
        provider: enums.OAuthProvider.amazon,
      );
    });

    test('test method createPhoneToken()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'bb8ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'secret': '',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'phrase': 'Golden Fox',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createPhoneToken(
        userId: '<USER_ID>',
        phone: '+12065550100',
      );
      expect(response, isA<models.Token>());
    });

    test('test method createEmailVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'bb8ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'secret': '',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'phrase': 'Golden Fox',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createEmailVerification(
        url: 'https://example.com',
      );
      expect(response, isA<models.Token>());
    });

    test('test method createVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'bb8ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'secret': '',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'phrase': 'Golden Fox',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createVerification(
        url: 'https://example.com',
      );
      expect(response, isA<models.Token>());
    });

    test('test method updateEmailVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'bb8ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'secret': '',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'phrase': 'Golden Fox',
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateEmailVerification(
        userId: '<USER_ID>',
        secret: '<SECRET>',
      );
      expect(response, isA<models.Token>());
    });

    test('test method updateVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'bb8ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'secret': '',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'phrase': 'Golden Fox',
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updateVerification(
        userId: '<USER_ID>',
        secret: '<SECRET>',
      );
      expect(response, isA<models.Token>());
    });

    test('test method createPhoneVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'bb8ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'secret': '',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'phrase': 'Golden Fox',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.createPhoneVerification();
      expect(response, isA<models.Token>());
    });

    test('test method updatePhoneVerification()', () async {
      final Map<String, dynamic> data = {
        '\$id': 'bb8ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        'userId': '5e5ea5c168bb8',
        'secret': '',
        'expire': '2020-10-15T06:38:00.000+00:00',
        'phrase': 'Golden Fox',
      };

      when(client.call(
        HttpMethod.put,
      )).thenAnswer((_) async => Response(data: data));

      final response = await account.updatePhoneVerification(
        userId: '<USER_ID>',
        secret: '<SECRET>',
      );
      expect(response, isA<models.Token>());
    });
  });
}
