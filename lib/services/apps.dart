part of '../appwrite.dart';

class Apps extends Service {
  /// Initializes a [Apps] service
  Apps(super.client);

  /// List applications.
  Future<models.AppsList> list({List<String>? queries, bool? total}) async {
    final String apiPath = '/apps';

        final Map<String, dynamic> apiParams = {
            if (queries != null) 'queries': queries,

            if (total != null) 'total': total,

        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.AppsList.fromMap(res.data);

  }

  /// Create a new application.
  Future<models.App> create({required String appId, required String name, required List<String> redirectUris, bool? enabled, String? type, bool? deviceFlow, String? teamId}) async {
    final String apiPath = '/apps';

        final Map<String, dynamic> apiParams = {
            'appId': appId,

            'name': name,

            'redirectUris': redirectUris,

            if (enabled != null) 'enabled': enabled,

            if (type != null) 'type': type,

            if (deviceFlow != null) 'deviceFlow': deviceFlow,

            if (teamId != null) 'teamId': teamId,

        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'content-type': 'application/json',            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.App.fromMap(res.data);

  }

  /// Get an application by its unique ID.
  Future<models.App> get({required String appId}) async {
    final String apiPath = '/apps/{appId}'.replaceAll('{appId}', appId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.App.fromMap(res.data);

  }

  /// Update an application by its unique ID.
  Future<models.App> update({required String appId, required String name, bool? enabled, List<String>? redirectUris, String? type, bool? deviceFlow}) async {
    final String apiPath = '/apps/{appId}'.replaceAll('{appId}', appId);

        final Map<String, dynamic> apiParams = {
            'name': name,

            if (enabled != null) 'enabled': enabled,

            if (redirectUris != null) 'redirectUris': redirectUris,

            if (type != null) 'type': type,

            if (deviceFlow != null) 'deviceFlow': deviceFlow,

        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'content-type': 'application/json',            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.App.fromMap(res.data);

  }

  /// Delete an application by its unique ID.
  Future delete({required String appId}) async {
    final String apiPath = '/apps/{appId}'.replaceAll('{appId}', appId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'content-type': 'application/json',            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

  }

  /// List client secrets for an application.
  Future<models.AppSecretList> listSecrets({required String appId, List<String>? queries, bool? total}) async {
    final String apiPath = '/apps/{appId}/secrets'.replaceAll('{appId}', appId);

        final Map<String, dynamic> apiParams = {
            if (queries != null) 'queries': queries,

            if (total != null) 'total': total,

        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.AppSecretList.fromMap(res.data);

  }

  /// Create a new client secret for an application.
  Future<models.AppSecretPlaintext> createSecret({required String appId}) async {
    final String apiPath = '/apps/{appId}/secrets'.replaceAll('{appId}', appId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'content-type': 'application/json',            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.AppSecretPlaintext.fromMap(res.data);

  }

  /// Get an application client secret by its unique ID.
  Future<models.AppSecret> getSecret({required String appId, required String secretId}) async {
    final String apiPath = '/apps/{appId}/secrets/{secretId}'.replaceAll('{appId}', appId).replaceAll('{secretId}', secretId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.AppSecret.fromMap(res.data);

  }

  /// Delete an application client secret by its unique ID.
  Future deleteSecret({required String appId, required String secretId}) async {
    final String apiPath = '/apps/{appId}/secrets/{secretId}'.replaceAll('{appId}', appId).replaceAll('{secretId}', secretId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'content-type': 'application/json',            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

  }

  /// Transfer an application to another team by its unique ID.
  Future<models.App> updateTeam({required String appId, required String teamId}) async {
    final String apiPath = '/apps/{appId}/team'.replaceAll('{appId}', appId);

        final Map<String, dynamic> apiParams = {
            'teamId': teamId,

        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'content-type': 'application/json',            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.App.fromMap(res.data);

  }

  /// Revoke all tokens for an application by its unique ID.
  Future deleteTokens({required String appId}) async {
    final String apiPath = '/apps/{appId}/tokens'.replaceAll('{appId}', appId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'content-type': 'application/json',            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

  }
}
