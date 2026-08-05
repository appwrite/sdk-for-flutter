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


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await organization.listInstallations(
            );
            expect(response, isA<models.AppInstallationList>());

        });

        test('test method createInstallation()', () async {

            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'appId': '5e5ea5c16897e',
                'teamId': '5e5ea5c16897e',
                'scopes': [],
                'authorizationDetails': <String, dynamic>{},
                'createdById': '5e5ea5c16897e',
                'createdByName': 'Walter White',

            };


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await organization.createInstallation(
                appId: '<APP_ID>',
            );
            expect(response, isA<models.AppInstallation>());

        });

        test('test method getInstallation()', () async {

            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'appId': '5e5ea5c16897e',
                'teamId': '5e5ea5c16897e',
                'scopes': [],
                'authorizationDetails': <String, dynamic>{},
                'createdById': '5e5ea5c16897e',
                'createdByName': 'Walter White',

            };


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await organization.getInstallation(
                installationId: '<INSTALLATION_ID>',
            );
            expect(response, isA<models.AppInstallation>());

        });

        test('test method updateInstallation()', () async {

            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'appId': '5e5ea5c16897e',
                'teamId': '5e5ea5c16897e',
                'scopes': [],
                'authorizationDetails': <String, dynamic>{},
                'createdById': '5e5ea5c16897e',
                'createdByName': 'Walter White',

            };


            when(client.call(
                HttpMethod.put,
            )).thenAnswer((_) async => Response(data: data));


            final response = await organization.updateInstallation(
                installationId: '<INSTALLATION_ID>',
            );
            expect(response, isA<models.AppInstallation>());

        });

        test('test method deleteInstallation()', () async {

            final data = '';

            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await organization.deleteInstallation(
                installationId: '<INSTALLATION_ID>',
            );
        });

    });
}
