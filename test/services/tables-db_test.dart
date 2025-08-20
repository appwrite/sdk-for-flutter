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
    group('TablesDb test', () {
        late MockClient client;
        late TablesDb tablesDb;

        setUp(() {
            client = MockClient();
            tablesDb = TablesDb(client);
        });

        test('test method listRows()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'rows': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await tablesDb.listRows(
                databaseId: '<DATABASE_ID>',
                tableId: '<TABLE_ID>',
            );
            expect(response, isA<models.RowList>());

        });

        test('test method createRow()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$sequence': 1,
                '\$tableId': '5e5ea5c15117e',
                '\$databaseId': '5e5ea5c15117e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await tablesDb.createRow(
                databaseId: '<DATABASE_ID>',
                tableId: '<TABLE_ID>',
                rowId: '<ROW_ID>',
                data: {},
            );
            expect(response, isA<models.Row>());

        });

        test('test method getRow()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$sequence': 1,
                '\$tableId': '5e5ea5c15117e',
                '\$databaseId': '5e5ea5c15117e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await tablesDb.getRow(
                databaseId: '<DATABASE_ID>',
                tableId: '<TABLE_ID>',
                rowId: '<ROW_ID>',
            );
            expect(response, isA<models.Row>());

        });

        test('test method upsertRow()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$sequence': 1,
                '\$tableId': '5e5ea5c15117e',
                '\$databaseId': '5e5ea5c15117e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],};


            when(client.call(
                HttpMethod.put,
            )).thenAnswer((_) async => Response(data: data));


            final response = await tablesDb.upsertRow(
                databaseId: '<DATABASE_ID>',
                tableId: '<TABLE_ID>',
                rowId: '<ROW_ID>',
            );
            expect(response, isA<models.Row>());

        });

        test('test method updateRow()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$sequence': 1,
                '\$tableId': '5e5ea5c15117e',
                '\$databaseId': '5e5ea5c15117e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                '\$permissions': [],};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await tablesDb.updateRow(
                databaseId: '<DATABASE_ID>',
                tableId: '<TABLE_ID>',
                rowId: '<ROW_ID>',
            );
            expect(response, isA<models.Row>());

        });

        test('test method deleteRow()', () async {
            final data = '';

            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await tablesDb.deleteRow(
                databaseId: '<DATABASE_ID>',
                tableId: '<TABLE_ID>',
                rowId: '<ROW_ID>',
            );
        });

    });
}