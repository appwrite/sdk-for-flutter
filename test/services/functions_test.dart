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

        test('test method retryBuild()', () async {
            final data = '';

            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await functions.retryBuild(
                functionId: '[FUNCTION_ID]',
                deploymentId: '[DEPLOYMENT_ID]',
                buildId: '[BUILD_ID]',
            );
        });

        test('test method listExecutions()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'executions': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await functions.listExecutions(
                functionId: '[FUNCTION_ID]',
            );
            expect(response, isA<models.ExecutionList>());

        });

        test('test method createExecution()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$read': [],
                'functionId': '5e5ea6g16897e',
                'dateCreated': 1592981250,
                'trigger': 'http',
                'status': 'processing',
                'statusCode': 0,
                'stdout': '',
                'stderr': '',
                'time': 0.4,};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await functions.createExecution(
                functionId: '[FUNCTION_ID]',
            );
            expect(response, isA<models.Execution>());

        });

        test('test method getExecution()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$read': [],
                'functionId': '5e5ea6g16897e',
                'dateCreated': 1592981250,
                'trigger': 'http',
                'status': 'processing',
                'statusCode': 0,
                'stdout': '',
                'stderr': '',
                'time': 0.4,};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await functions.getExecution(
                functionId: '[FUNCTION_ID]',
                executionId: '[EXECUTION_ID]',
            );
            expect(response, isA<models.Execution>());

        });

    });
}