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
    group('DocumentsDB test', () {
        late MockClient client;
        late DocumentsDB documentsDB;

        setUp(() {
            client = MockClient();
            documentsDB = DocumentsDB(client);
        });

        test('test method listTransactions()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'transactions': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.listTransactions(
            );
            expect(response, isA<models.TransactionList>());

        });

        test('test method createTransaction()', () async {
            final Map<String, dynamic> data = {
                '\$id': '259125845563242502',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'status': 'pending',
                'operations': 5,
                'expiresAt': '2020-10-15T06:38:00.000+00:00',};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.createTransaction(
            );
            expect(response, isA<models.Transaction>());

        });

        test('test method getTransaction()', () async {
            final Map<String, dynamic> data = {
                '\$id': '259125845563242502',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'status': 'pending',
                'operations': 5,
                'expiresAt': '2020-10-15T06:38:00.000+00:00',};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.getTransaction(
                transactionId: '<TRANSACTION_ID>',
            );
            expect(response, isA<models.Transaction>());

        });

        test('test method updateTransaction()', () async {
            final Map<String, dynamic> data = {
                '\$id': '259125845563242502',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'status': 'pending',
                'operations': 5,
                'expiresAt': '2020-10-15T06:38:00.000+00:00',};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.updateTransaction(
                transactionId: '<TRANSACTION_ID>',
            );
            expect(response, isA<models.Transaction>());

        });

        test('test method deleteTransaction()', () async {
            final data = '';

            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.deleteTransaction(
                transactionId: '<TRANSACTION_ID>',
            );
        });

        test('test method createOperations()', () async {
            final Map<String, dynamic> data = {
                '\$id': '259125845563242502',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'status': 'pending',
                'operations': 5,
                'expiresAt': '2020-10-15T06:38:00.000+00:00',};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.createOperations(
                transactionId: '<TRANSACTION_ID>',
            );
            expect(response, isA<models.Transaction>());

        });

        test('test method listDocuments()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'documents': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.listDocuments(
                databaseId: '<DATABASE_ID>',
                collectionId: '<COLLECTION_ID>',
            );
            expect(response, isA<models.DocumentList>());

        });

        test('test method createDocument()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$sequence': '1',
                '\$collectionId': '5e5ea5c15117e',
                '\$databaseId': '5e5ea5c15117e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.createDocument(
                databaseId: '<DATABASE_ID>',
                collectionId: '<COLLECTION_ID>',
                documentId: '<DOCUMENT_ID>',
                data: {},
            );
            expect(response, isA<models.Document>());

        });

        test('test method createDocuments()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'documents': [],};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.createDocuments(
                databaseId: '<DATABASE_ID>',
                collectionId: '<COLLECTION_ID>',
                documents: [],
            );
            expect(response, isA<models.DocumentList>());

        });

        test('test method getDocument()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$sequence': '1',
                '\$collectionId': '5e5ea5c15117e',
                '\$databaseId': '5e5ea5c15117e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.getDocument(
                databaseId: '<DATABASE_ID>',
                collectionId: '<COLLECTION_ID>',
                documentId: '<DOCUMENT_ID>',
            );
            expect(response, isA<models.Document>());

        });

        test('test method upsertDocument()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$sequence': '1',
                '\$collectionId': '5e5ea5c15117e',
                '\$databaseId': '5e5ea5c15117e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],};


            when(client.call(
                HttpMethod.put,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.upsertDocument(
                databaseId: '<DATABASE_ID>',
                collectionId: '<COLLECTION_ID>',
                documentId: '<DOCUMENT_ID>',
            );
            expect(response, isA<models.Document>());

        });

        test('test method updateDocument()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$sequence': '1',
                '\$collectionId': '5e5ea5c15117e',
                '\$databaseId': '5e5ea5c15117e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.updateDocument(
                databaseId: '<DATABASE_ID>',
                collectionId: '<COLLECTION_ID>',
                documentId: '<DOCUMENT_ID>',
            );
            expect(response, isA<models.Document>());

        });

        test('test method deleteDocument()', () async {
            final data = '';

            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.deleteDocument(
                databaseId: '<DATABASE_ID>',
                collectionId: '<COLLECTION_ID>',
                documentId: '<DOCUMENT_ID>',
            );
        });

        test('test method decrementDocumentAttribute()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$sequence': '1',
                '\$collectionId': '5e5ea5c15117e',
                '\$databaseId': '5e5ea5c15117e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.decrementDocumentAttribute(
                databaseId: '<DATABASE_ID>',
                collectionId: '<COLLECTION_ID>',
                documentId: '<DOCUMENT_ID>',
                attribute: '',
            );
            expect(response, isA<models.Document>());

        });

        test('test method incrementDocumentAttribute()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$sequence': '1',
                '\$collectionId': '5e5ea5c15117e',
                '\$databaseId': '5e5ea5c15117e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await documentsDB.incrementDocumentAttribute(
                databaseId: '<DATABASE_ID>',
                collectionId: '<COLLECTION_ID>',
                documentId: '<DOCUMENT_ID>',
                attribute: '',
            );
            expect(response, isA<models.Document>());

        });

    });
}