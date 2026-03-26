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
    group('Messaging test', () {
        late MockClient client;
        late Messaging messaging;

        setUp(() {
            client = MockClient();
            messaging = Messaging(client);
        });

        test('test method createSubscriber()', () async {
            final Map<String, dynamic> data = {
                '\$id': '259125845563242502',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'targetId': '259125845563242502',
                'target': <String, dynamic>{
    '\$id': '259125845563242502',
    '\$createdAt': '2020-10-15T06:38:00.000+00:00',
    '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
    'name': 'Apple iPhone 12',
    'userId': '259125845563242502',
    'providerType': 'email',
    'identifier': 'token',
    'expired': true,
  },
                'userId': '5e5ea5c16897e',
                'userName': 'Aegon Targaryen',
                'topicId': '259125845563242502',
                'providerType': 'email',};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await messaging.createSubscriber(
                topicId: '<TOPIC_ID>',
                subscriberId: '<SUBSCRIBER_ID>',
                targetId: '<TARGET_ID>',
            );
            expect(response, isA<models.Subscriber>());

        });

        test('test method deleteSubscriber()', () async {
            final data = '';

            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await messaging.deleteSubscriber(
                topicId: '<TOPIC_ID>',
                subscriberId: '<SUBSCRIBER_ID>',
            );
        });

    });
}