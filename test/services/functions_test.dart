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
  group('Functions test', () {
    late MockClient client;
    late Functions functions;

    setUp(() {
      client = MockClient();
      functions = Functions(client);
    });

    test('test method listExecutions()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'executions': [],
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

      final response = await functions.listExecutions(
        functionId: "<FUNCTION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/functions/<FUNCTION_ID>/executions",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.ExecutionList>());
    });

    test('test method createExecution()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        '\$permissions': [],
        'resourceId': "5e5ea6g16897e",
        'resourceType': "functions",
        'deploymentId': "5e5ea5c16897e",
        'trigger': "http",
        'status': "processing",
        'requestMethod': "GET",
        'requestPath': "/articles?id=5",
        'requestHeaders': [],
        'responseStatusCode': 200,
        'responseBody': "",
        'responseHeaders': [],
        'logs': "",
        'errors': "",
        'duration': 1.23,
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

      final response = await functions.createExecution(
        functionId: "<FUNCTION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/functions/<FUNCTION_ID>/executions",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Execution>());
    });

    test('test method getExecution()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        '\$permissions': [],
        'resourceId': "5e5ea6g16897e",
        'resourceType': "functions",
        'deploymentId': "5e5ea5c16897e",
        'trigger': "http",
        'status': "processing",
        'requestMethod': "GET",
        'requestPath': "/articles?id=5",
        'requestHeaders': [],
        'responseStatusCode': 200,
        'responseBody': "",
        'responseHeaders': [],
        'logs': "",
        'errors': "",
        'duration': 1.23,
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

      final response = await functions.getExecution(
        functionId: "<FUNCTION_ID>",
        executionId: "<EXECUTION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/functions/<FUNCTION_ID>/executions/<EXECUTION_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.Execution>());
    });
  });
}
