part of '../appwrite.dart';

  /// The Organization service allows you to manage organization-level projects.
class Organization extends Service {
  /// Initializes a [Organization] service
  Organization(super.client);

  /// List app installations on the organization. Any organization member can
  /// read installations.
  Future<models.AppInstallationList> listInstallations({List<String>? queries, bool? total}) async {
    final String apiPath = '/organization/installations';

        final Map<String, dynamic> apiParams = {
            if (queries != null) 'queries': queries,

            if (total != null) 'total': total,

        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.AppInstallationList.fromMap(res.data);

  }

  /// Install an app on the organization. Only organization members with the
  /// owner role can install apps. The installation is granted the scopes the app
  /// currently requests.
  Future<models.AppInstallation> createInstallation({required String appId, String? authorizationDetails}) async {
    final String apiPath = '/organization/installations';

        final Map<String, dynamic> apiParams = {
            'appId': appId,

            if (authorizationDetails != null) 'authorizationDetails': authorizationDetails,

        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'content-type': 'application/json',            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.AppInstallation.fromMap(res.data);

  }

  /// Get an app installation on the organization by its unique ID. Any
  /// organization member can read installations.
  Future<models.AppInstallation> getInstallation({required String installationId}) async {
    final String apiPath = '/organization/installations/{installationId}'.replaceAll('{installationId}', installationId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.AppInstallation.fromMap(res.data);

  }

  /// Update an app installation on the organization. Only organization members
  /// with the owner role can update installations. The installation's granted
  /// scopes are refreshed to the scopes the app currently requests; previously
  /// issued installation access tokens are revoked.
  Future<models.AppInstallation> updateInstallation({required String installationId, String? authorizationDetails}) async {
    final String apiPath = '/organization/installations/{installationId}'.replaceAll('{installationId}', installationId);

        final Map<String, dynamic> apiParams = {
            if (authorizationDetails != null) 'authorizationDetails': authorizationDetails,

        };

        final Map<String, String> apiHeaders = {
            'X-Appwrite-Project': client.config['project'] ?? '',
            'content-type': 'application/json',            'accept': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.AppInstallation.fromMap(res.data);

  }

  /// Uninstall an app from the organization by its installation ID. Only
  /// organization members with the owner role can remove installations.
  /// Previously issued installation access tokens are revoked.
  Future deleteInstallation({required String installationId}) async {
    final String apiPath = '/organization/installations/{installationId}'.replaceAll('{installationId}', installationId);

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
