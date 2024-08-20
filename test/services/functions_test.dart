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
    group('Functions test', () {
        late MockClient client;
        late Functions functions;

        setUp(() {
            client = MockClient();
            functions = Functions(client);
        });

        test('test method listTemplates()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'templates': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await functions.listTemplates(
            );
            expect(response, isA<models.TemplateFunctionList>());

        });

        test('test method getTemplate()', () async {
            final Map<String, dynamic> data = {
                'icon': 'icon-lightning-bolt',
                'id': 'starter',
                'name': 'Starter function',
                'tagline': 'A simple function to get started.',
                'permissions': [],
                'events': [],
                'cron': '0 0 * * *',
                'timeout': 300,
                'useCases': [],
                'runtimes': [],
                'instructions': 'For documentation and instructions check out <link>.',
                'vcsProvider': 'github',
                'providerRepositoryId': 'templates',
                'providerOwner': 'appwrite',
                'providerVersion': 'main',
                'variables': [],
                'scopes': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await functions.getTemplate(
                templateId: '<TEMPLATE_ID>',
            );
            expect(response, isA<models.TemplateFunction>());

        });

        test('test method getDeploymentDownload()', () async {final Uint8List data = Uint8List.fromList([]);

            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await functions.getDeploymentDownload(
                functionId: '<FUNCTION_ID>',
                deploymentId: '<DEPLOYMENT_ID>',
            );
            expect(response, isA<Uint8List>());

        });

        test('test method listExecutions()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'executions': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await functions.listExecutions(
                functionId: '<FUNCTION_ID>',
            );
            expect(response, isA<models.ExecutionList>());

        });

        test('test method createExecution()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],
                'functionId': '5e5ea6g16897e',
                'trigger': 'http',
                'status': 'processing',
                'requestMethod': 'GET',
                'requestPath': '/articles?id=5',
                'requestHeaders': [],
                'responseStatusCode': 200,
                'responseBody': 'Developers are awesome.',
                'responseHeaders': [],
                'logs': '',
                'errors': '',
                'duration': 0.4,};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await functions.createExecution(
                functionId: '<FUNCTION_ID>',
            );
            expect(response, isA<models.Execution>());

        });

        test('test method getExecution()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],
                'functionId': '5e5ea6g16897e',
                'trigger': 'http',
                'status': 'processing',
                'requestMethod': 'GET',
                'requestPath': '/articles?id=5',
                'requestHeaders': [],
                'responseStatusCode': 200,
                'responseBody': 'Developers are awesome.',
                'responseHeaders': [],
                'logs': '',
                'errors': '',
                'duration': 0.4,};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await functions.getExecution(
                functionId: '<FUNCTION_ID>',
                executionId: '<EXECUTION_ID>',
            );
            expect(response, isA<models.Execution>());

        });

    });
}