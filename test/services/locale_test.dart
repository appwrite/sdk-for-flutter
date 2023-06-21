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
    group('Locale test', () {
        late MockClient client;
        late Locale locale;

        setUp(() {
            client = MockClient();
            locale = Locale(client);
        });

        test('test method get()', () async {
            final Map<String, dynamic> data = {
                'ip': '127.0.0.1',
                'countryCode': 'US',
                'country': 'United States',
                'continentCode': 'NA',
                'continent': 'North America',
                'eu': true,
                'currency': 'USD',};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await locale.get(
            );
            expect(response, isA<models.Locale>());

        });

        test('test method getContinents()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'continents': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await locale.getContinents(
            );
            expect(response, isA<models.ContinentList>());

        });

        test('test method getCountries()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'countries': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await locale.getCountries(
            );
            expect(response, isA<models.CountryList>());

        });

        test('test method getCountriesEU()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'countries': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await locale.getCountriesEU(
            );
            expect(response, isA<models.CountryList>());

        });

        test('test method getCountriesPhones()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'phones': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await locale.getCountriesPhones(
            );
            expect(response, isA<models.PhoneList>());

        });

        test('test method getCurrencies()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'currencies': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await locale.getCurrencies(
            );
            expect(response, isA<models.CurrencyList>());

        });

        test('test method getLanguages()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'languages': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await locale.getLanguages(
            );
            expect(response, isA<models.LanguageList>());

        });

    });
}