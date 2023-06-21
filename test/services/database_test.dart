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
    group('Database test', () {
        late MockClient client;
        late Database database;

        setUp(() {
            client = MockClient();
            database = Database(client);
        });

        test('test method listDocuments()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'documents': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await database.listDocuments(
                collectionId: '[COLLECTION_ID]',
            );
            expect(response, isA<models.DocumentList>());

        });

        test('test method createDocument()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$collection': '5e5ea5c15117e',
                '\$read': [],
                '\$write': [],};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await database.createDocument(
                collectionId: '[COLLECTION_ID]',
                documentId: '[DOCUMENT_ID]',
                data: {},
            );
            expect(response, isA<models.Document>());

        });

        test('test method getDocument()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$collection': '5e5ea5c15117e',
                '\$read': [],
                '\$write': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await database.getDocument(
                collectionId: '[COLLECTION_ID]',
                documentId: '[DOCUMENT_ID]',
            );
            expect(response, isA<models.Document>());

        });

        test('test method updateDocument()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$collection': '5e5ea5c15117e',
                '\$read': [],
                '\$write': [],};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await database.updateDocument(
                collectionId: '[COLLECTION_ID]',
                documentId: '[DOCUMENT_ID]',
                data: {},
            );
            expect(response, isA<models.Document>());

        });

        test('test method deleteDocument()', () async {
            final data = '';

            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await database.deleteDocument(
                collectionId: '[COLLECTION_ID]',
                documentId: '[DOCUMENT_ID]',
            );
        });

    });
}