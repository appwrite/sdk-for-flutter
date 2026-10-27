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
        'teams': [],
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

      final response = await teams.list(
        queries: [],
        search: "<SEARCH>",
        total: false,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/teams",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "queries": isA<List>(),
        "search": "<SEARCH>",
        "total": false,
      });
      expect(response, isA<models.TeamList>());
    });

    test('test method create()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "VIP",
        'total': 7,
        'prefs': <String, dynamic>{},
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

      final response = await teams.create(
        teamId: "<TEAM_ID>",
        name: "<NAME>",
        roles: [],
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/teams",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "teamId": "<TEAM_ID>",
        "name": "<NAME>",
        "roles": isA<List>(),
      });
      expect(response, isA<models.Team>());
    });

    test('test method get()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "VIP",
        'total': 7,
        'prefs': <String, dynamic>{},
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

      final response = await teams.get(
        teamId: "<TEAM_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/teams/%3CTEAM_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<models.Team>());
    });

    test('test method updateName()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'name': "VIP",
        'total': 7,
        'prefs': <String, dynamic>{},
      };

      when(
        client.call(
          HttpMethod.put,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await teams.updateName(
        teamId: "<TEAM_ID>",
        name: "<NAME>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/teams/%3CTEAM_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "name": "<NAME>",
      });
      expect(response, isA<models.Team>());
    });

    test('test method delete()', () async {
      final data = '';

      when(
        client.call(
          HttpMethod.delete,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await teams.delete(
        teamId: "<TEAM_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/teams/%3CTEAM_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
    });

    test('test method listInstallations()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'installations': [],
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

      final response = await teams.listInstallations(
        teamId: "<TEAM_ID>",
        queries: [],
        total: false,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/teams/%3CTEAM_ID%3E/installations",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "queries": isA<List>(),
        "total": false,
      });
      expect(response, isA<models.AppInstallationList>());
    });

    test('test method createInstallation()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'appId': "5e5ea5c16897e",
        'teamId': "5e5ea5c16897e",
        'scopes': [],
        'authorizationDetails': [],
        'createdById': "5e5ea5c16897e",
        'createdByName': "Walter White",
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

      final response = await teams.createInstallation(
        teamId: "<TEAM_ID>",
        appId: "<APP_ID>",
        authorizationDetails: "<AUTHORIZATION_DETAILS>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/teams/%3CTEAM_ID%3E/installations",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "appId": "<APP_ID>",
        "authorizationDetails": "<AUTHORIZATION_DETAILS>",
      });
      expect(response, isA<models.AppInstallation>());
    });

    test('test method getInstallation()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'appId': "5e5ea5c16897e",
        'teamId': "5e5ea5c16897e",
        'scopes': [],
        'authorizationDetails': [],
        'createdById': "5e5ea5c16897e",
        'createdByName': "Walter White",
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

      final response = await teams.getInstallation(
        teamId: "<TEAM_ID>",
        installationId: "<INSTALLATION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/teams/%3CTEAM_ID%3E/installations/%3CINSTALLATION_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<models.AppInstallation>());
    });

    test('test method updateInstallation()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'appId': "5e5ea5c16897e",
        'teamId': "5e5ea5c16897e",
        'scopes': [],
        'authorizationDetails': [],
        'createdById': "5e5ea5c16897e",
        'createdByName': "Walter White",
      };

      when(
        client.call(
          HttpMethod.put,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await teams.updateInstallation(
        teamId: "<TEAM_ID>",
        installationId: "<INSTALLATION_ID>",
        authorizationDetails: "<AUTHORIZATION_DETAILS>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/teams/%3CTEAM_ID%3E/installations/%3CINSTALLATION_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "authorizationDetails": "<AUTHORIZATION_DETAILS>",
      });
      expect(response, isA<models.AppInstallation>());
    });

    test('test method deleteInstallation()', () async {
      final data = '';

      when(
        client.call(
          HttpMethod.delete,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await teams.deleteInstallation(
        teamId: "<TEAM_ID>",
        installationId: "<INSTALLATION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/teams/%3CTEAM_ID%3E/installations/%3CINSTALLATION_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
    });

    test('test method listMemberships()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'memberships': [],
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

      final response = await teams.listMemberships(
        teamId: "<TEAM_ID>",
        queries: [],
        search: "<SEARCH>",
        total: false,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/teams/%3CTEAM_ID%3E/memberships",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "queries": isA<List>(),
        "search": "<SEARCH>",
        "total": false,
      });
      expect(response, isA<models.MembershipList>());
    });

    test('test method createMembership()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c16897e",
        'userName': "John Doe",
        'userEmail': "john@appwrite.io",
        'userPhone': "+1 555 555 5555",
        'teamId': "5e5ea5c16897e",
        'teamName': "VIP",
        'invited': "2020-10-15T06:38:00.000+00:00",
        'joined': "2020-10-15T06:38:00.000+00:00",
        'confirm': true,
        'mfa': true,
        'userAccessedAt': "2020-10-15T06:38:00.000+00:00",
        'roles': [],
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

      final response = await teams.createMembership(
        teamId: "<TEAM_ID>",
        roles: [],
        email: "email@example.com",
        userId: "<USER_ID>",
        phone: "+12065550100",
        url: "https://example.com",
        name: "<NAME>",
        membershipId: "<MEMBERSHIP_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/teams/%3CTEAM_ID%3E/memberships",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "email": "email@example.com",
        "userId": "<USER_ID>",
        "phone": "+12065550100",
        "roles": isA<List>(),
        "url": "https://example.com",
        "name": "<NAME>",
        "membershipId": "<MEMBERSHIP_ID>",
      });
      expect(response, isA<models.Membership>());
    });

    test('test method getMembership()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c16897e",
        'userName': "John Doe",
        'userEmail': "john@appwrite.io",
        'userPhone': "+1 555 555 5555",
        'teamId': "5e5ea5c16897e",
        'teamName': "VIP",
        'invited': "2020-10-15T06:38:00.000+00:00",
        'joined': "2020-10-15T06:38:00.000+00:00",
        'confirm': true,
        'mfa': true,
        'userAccessedAt': "2020-10-15T06:38:00.000+00:00",
        'roles': [],
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

      final response = await teams.getMembership(
        teamId: "<TEAM_ID>",
        membershipId: "<MEMBERSHIP_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/teams/%3CTEAM_ID%3E/memberships/%3CMEMBERSHIP_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<models.Membership>());
    });

    test('test method updateMembership()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c16897e",
        'userName': "John Doe",
        'userEmail': "john@appwrite.io",
        'userPhone': "+1 555 555 5555",
        'teamId': "5e5ea5c16897e",
        'teamName': "VIP",
        'invited': "2020-10-15T06:38:00.000+00:00",
        'joined': "2020-10-15T06:38:00.000+00:00",
        'confirm': true,
        'mfa': true,
        'userAccessedAt': "2020-10-15T06:38:00.000+00:00",
        'roles': [],
      };

      when(
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await teams.updateMembership(
        teamId: "<TEAM_ID>",
        membershipId: "<MEMBERSHIP_ID>",
        roles: [],
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/teams/%3CTEAM_ID%3E/memberships/%3CMEMBERSHIP_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "roles": isA<List>(),
      });
      expect(response, isA<models.Membership>());
    });

    test('test method deleteMembership()', () async {
      final data = '';

      when(
        client.call(
          HttpMethod.delete,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await teams.deleteMembership(
        teamId: "<TEAM_ID>",
        membershipId: "<MEMBERSHIP_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/teams/%3CTEAM_ID%3E/memberships/%3CMEMBERSHIP_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
    });

    test('test method updateMembershipStatus()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'userId': "5e5ea5c16897e",
        'userName': "John Doe",
        'userEmail': "john@appwrite.io",
        'userPhone': "+1 555 555 5555",
        'teamId': "5e5ea5c16897e",
        'teamName': "VIP",
        'invited': "2020-10-15T06:38:00.000+00:00",
        'joined': "2020-10-15T06:38:00.000+00:00",
        'confirm': true,
        'mfa': true,
        'userAccessedAt': "2020-10-15T06:38:00.000+00:00",
        'roles': [],
      };

      when(
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await teams.updateMembershipStatus(
        teamId: "<TEAM_ID>",
        membershipId: "<MEMBERSHIP_ID>",
        userId: "<USER_ID>",
        secret: "<SECRET>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/teams/%3CTEAM_ID%3E/memberships/%3CMEMBERSHIP_ID%3E/status",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "userId": "<USER_ID>",
        "secret": "<SECRET>",
      });
      expect(response, isA<models.Membership>());
    });

    test('test method getPrefs()', () async {
      final Map<String, dynamic> data = {};

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await teams.getPrefs(
        teamId: "<TEAM_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/teams/%3CTEAM_ID%3E/prefs",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<models.Preferences>());
    });

    test('test method updatePrefs()', () async {
      final Map<String, dynamic> data = {};

      when(
        client.call(
          HttpMethod.put,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await teams.updatePrefs(
        teamId: "<TEAM_ID>",
        prefs: {},
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/teams/%3CTEAM_ID%3E/prefs",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "prefs": isA<Map>(),
      });
      expect(response, isA<models.Preferences>());
    });
  });
}
