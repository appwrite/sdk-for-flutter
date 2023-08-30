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
    group('Vcs test', () {
        late MockClient client;
        late Vcs vcs;

        setUp(() {
            client = MockClient();
            vcs = Vcs(client);
        });

        test('test method listRepositories()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'providerRepositories': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await vcs.listRepositories(
                installationId: '[INSTALLATION_ID]',
            );
            expect(response, isA<models.ProviderRepositoryList>());

        });

        test('test method createRepository()', () async {
            final Map<String, dynamic> data = {
                'id': '5e5ea5c16897e',
                'name': 'appwrite',
                'organization': 'appwrite',
                'provider': 'github',
                'private': true,
                'runtime': 'node',
                'pushedAt': 'datetime',};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await vcs.createRepository(
                installationId: '[INSTALLATION_ID]',
                name: '[NAME]',
                private: true,
            );
            expect(response, isA<models.ProviderRepository>());

        });

        test('test method getRepository()', () async {
            final Map<String, dynamic> data = {
                'id': '5e5ea5c16897e',
                'name': 'appwrite',
                'organization': 'appwrite',
                'provider': 'github',
                'private': true,
                'runtime': 'node',
                'pushedAt': 'datetime',};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await vcs.getRepository(
                installationId: '[INSTALLATION_ID]',
                providerRepositoryId: '[PROVIDER_REPOSITORY_ID]',
            );
            expect(response, isA<models.ProviderRepository>());

        });

        test('test method listRepositoryBranches()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'branches': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await vcs.listRepositoryBranches(
                installationId: '[INSTALLATION_ID]',
                providerRepositoryId: '[PROVIDER_REPOSITORY_ID]',
            );
            expect(response, isA<models.BranchList>());

        });

        test('test method createRepositoryDetection()', () async {
            final Map<String, dynamic> data = {
                'runtime': 'node',};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await vcs.createRepositoryDetection(
                installationId: '[INSTALLATION_ID]',
                providerRepositoryId: '[PROVIDER_REPOSITORY_ID]',
            );
            expect(response, isA<models.Detection>());

        });

        test('test method updateExternalDeployments()', () async {
            final data = '';

            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await vcs.updateExternalDeployments(
                installationId: '[INSTALLATION_ID]',
                repositoryId: '[REPOSITORY_ID]',
                providerPullRequestId: '[PROVIDER_PULL_REQUEST_ID]',
            );
        });

    });
}