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
  group('Organizations test', () {
    late MockClient client;
    late Organizations organizations;

    setUp(() {
      client = MockClient();
      organizations = Organizations(client);
    });

    test('test method delete()', () async {
      final data = '';

      when(client.call(
        HttpMethod.delete,
      )).thenAnswer((_) async => Response(data: data));

      final response = await organizations.delete(
        organizationId: '<ORGANIZATION_ID>',
      );
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

      final response = await organizations.getBillingAddress(
        organizationId: '<ORGANIZATION_ID>',
        billingAddressId: '<BILLING_ADDRESS_ID>',
      );
      expect(response, isA<models.BillingAddress>());
    });

    test('test method estimationDeleteOrganization()', () async {
      final Map<String, dynamic> data = {
        'unpaidInvoices': [],
      };

      when(client.call(
        HttpMethod.patch,
      )).thenAnswer((_) async => Response(data: data));

      final response = await organizations.estimationDeleteOrganization(
        organizationId: '<ORGANIZATION_ID>',
      );
      expect(response, isA<models.EstimationDeleteOrganization>());
    });

    test('test method createDowngradeFeedback()', () async {
      final Map<String, dynamic> data = {
        '\$id': '5e5ea5c16897e',
        '\$createdAt': '2020-10-15T06:38:00.000+00:00',
        '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
        'title':
            'I encountered a bug and outage that caused my app to lose its value',
        'message':
            'The platform experienced significant downtime which affected my users.',
        'fromPlanId': 'pro',
        'toPlanId': 'free',
        'teamId': '5e5ea5c16897e',
        'userId': '5e5ea5c16897e',
        'version': '1.8.0',
      };

      when(client.call(
        HttpMethod.post,
      )).thenAnswer((_) async => Response(data: data));

      final response = await organizations.createDowngradeFeedback(
        organizationId: '<ORGANIZATION_ID>',
        reason: '<REASON>',
        message: '<MESSAGE>',
        fromPlanId: '<FROM_PLAN_ID>',
        toPlanId: '<TO_PLAN_ID>',
      );
      expect(response, isA<models.DowngradeFeedback>());
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

      final response = await organizations.getPaymentMethod(
        organizationId: '<ORGANIZATION_ID>',
        paymentMethodId: '<PAYMENT_METHOD_ID>',
      );
      expect(response, isA<models.PaymentMethod>());
    });
  });
}
