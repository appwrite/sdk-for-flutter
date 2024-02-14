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
    group('Teams test', () {
        late MockClient client;
        late Teams teams;

        setUp(() {
            client = MockClient();
            teams = Teams(client);
        });

        test('test method list()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'teams': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.list(
            );
            expect(response, isA<models.TeamList>());

        });

        test('test method create()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'name': 'VIP',
                'total': 7,
                'prefs': <String, dynamic>{},};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.create(
                teamId: '[TEAM_ID]',
                name: '[NAME]',
            );
            expect(response, isA<models.Team>());

        });

        test('test method get()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'name': 'VIP',
                'total': 7,
                'prefs': <String, dynamic>{},};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.get(
                teamId: '[TEAM_ID]',
            );
            expect(response, isA<models.Team>());

        });

        test('test method updateName()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'name': 'VIP',
                'total': 7,
                'prefs': <String, dynamic>{},};


            when(client.call(
                HttpMethod.put,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.updateName(
                teamId: '[TEAM_ID]',
                name: '[NAME]',
            );
            expect(response, isA<models.Team>());

        });

        test('test method delete()', () async {
            final data = '';

            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.delete(
                teamId: '[TEAM_ID]',
            );
        });

        test('test method listMemberships()', () async {
            final Map<String, dynamic> data = {
                'total': 5,
                'memberships': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.listMemberships(
                teamId: '[TEAM_ID]',
            );
            expect(response, isA<models.MembershipList>());

        });

        test('test method createMembership()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'userId': '5e5ea5c16897e',
                'userName': 'John Doe',
                'userEmail': 'john@appwrite.io',
                'teamId': '5e5ea5c16897e',
                'teamName': 'VIP',
                'invited': '2020-10-15T06:38:00.000+00:00',
                'joined': '2020-10-15T06:38:00.000+00:00',
                'confirm': true,
                'roles': [],};


            when(client.call(
                HttpMethod.post,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.createMembership(
                teamId: '[TEAM_ID]',
                roles: [],
            );
            expect(response, isA<models.Membership>());

        });

        test('test method getMembership()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'userId': '5e5ea5c16897e',
                'userName': 'John Doe',
                'userEmail': 'john@appwrite.io',
                'teamId': '5e5ea5c16897e',
                'teamName': 'VIP',
                'invited': '2020-10-15T06:38:00.000+00:00',
                'joined': '2020-10-15T06:38:00.000+00:00',
                'confirm': true,
                'roles': [],};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.getMembership(
                teamId: '[TEAM_ID]',
                membershipId: '[MEMBERSHIP_ID]',
            );
            expect(response, isA<models.Membership>());

        });

        test('test method updateMembership()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'userId': '5e5ea5c16897e',
                'userName': 'John Doe',
                'userEmail': 'john@appwrite.io',
                'teamId': '5e5ea5c16897e',
                'teamName': 'VIP',
                'invited': '2020-10-15T06:38:00.000+00:00',
                'joined': '2020-10-15T06:38:00.000+00:00',
                'confirm': true,
                'roles': [],};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.updateMembership(
                teamId: '[TEAM_ID]',
                membershipId: '[MEMBERSHIP_ID]',
                roles: [],
            );
            expect(response, isA<models.Membership>());

        });

        test('test method deleteMembership()', () async {
            final data = '';

            when(client.call(
                HttpMethod.delete,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.deleteMembership(
                teamId: '[TEAM_ID]',
                membershipId: '[MEMBERSHIP_ID]',
            );
        });

        test('test method updateMembershipStatus()', () async {
            final Map<String, dynamic> data = {
                '\$id': '5e5ea5c16897e',
                '\$createdAt': '2020-10-15T06:38:00.000+00:00',
                '\$updatedAt': '2020-10-15T06:38:00.000+00:00',
                'userId': '5e5ea5c16897e',
                'userName': 'John Doe',
                'userEmail': 'john@appwrite.io',
                'teamId': '5e5ea5c16897e',
                'teamName': 'VIP',
                'invited': '2020-10-15T06:38:00.000+00:00',
                'joined': '2020-10-15T06:38:00.000+00:00',
                'confirm': true,
                'roles': [],};


            when(client.call(
                HttpMethod.patch,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.updateMembershipStatus(
                teamId: '[TEAM_ID]',
                membershipId: '[MEMBERSHIP_ID]',
                userId: '[USER_ID]',
                secret: '[SECRET]',
            );
            expect(response, isA<models.Membership>());

        });

        test('test method getPrefs()', () async {
            final Map<String, dynamic> data = {};


            when(client.call(
                HttpMethod.get,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.getPrefs(
                teamId: '[TEAM_ID]',
            );
            expect(response, isA<models.Preferences>());

        });

        test('test method updatePrefs()', () async {
            final Map<String, dynamic> data = {};


            when(client.call(
                HttpMethod.put,
            )).thenAnswer((_) async => Response(data: data));


            final response = await teams.updatePrefs(
                teamId: '[TEAM_ID]',
                prefs: {},
            );
            expect(response, isA<models.Preferences>());

        });

    });
}