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
    group('Advisor test', () {
        late MockClient client;
        late Advisor advisor;

        setUp(() {
            client = MockClient();
            advisor = Advisor(client);
        });

        test('test method listReports()', () async {

            final Map<String, dynamic> data = {
                'total': 5,
                'reports': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await advisor.listReports(
            );
            expect(response, isA<models.ReportList>());

        });

        test('test method getReport()', () async {

            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'appId': '5e5ea5c16897e',
                'type': 'lighthouse',
                'title': 'Lighthouse audit for https://appwrite.io/',
                'summary': 'Performance score 78. 4 opportunities found.',
                'targetType': 'urls',
                'target': 'https://appwrite.io/',
                'categories': [],
                'insights': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await advisor.getReport(
                reportId: '<REPORT_ID>',
            );
            expect(response, isA<models.Report>());

        });

        test('test method listInsights()', () async {

            final Map<String, dynamic> data = {
                'total': 5,
                'insights': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await advisor.listInsights(
                reportId: '<REPORT_ID>',
            );
            expect(response, isA<models.InsightList>());

        });

        test('test method getInsight()', () async {

            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'reportId': '5e5ea5c16897e',
                'type': 'tablesDBIndex',
                'severity': 'warning',
                'status': 'active',
                'resourceType': 'databases',
                'resourceId': 'main',
                'parentResourceType': 'tables',
                'parentResourceId': 'orders',
                'title': 'Missing index on collection orders',
                'summary': 'Queries against `orders.status` are scanning the full collection.',
                'ctas': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await advisor.getInsight(
                reportId: '<REPORT_ID>',
                insightId: '<INSIGHT_ID>',
            );
            expect(response, isA<models.Insight>());

        });

    });
}
