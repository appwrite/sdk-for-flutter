part of '../appwrite.dart';

/// The Apps service allows you to manage OAuth2 applications, their keys,
/// secrets, scopes, and installations.
class Apps extends Service {
  /// Initializes a [Apps] service
  Apps(super.client);

  /// List applications.
  Future<models.AppsList> list({
    List<String>? queries,
    bool? total,
  }) async {
    final String apiPath = '/apps';

    final Map<String, dynamic> apiParams = {
      if (queries != null) 'queries': queries,
      if (total != null) 'total': total,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.AppsList.fromMap(res.data);
  }

  /// Create a new application.
  Future<models.App> create({
    required String appId,
    required String name,
    required List<String> redirectUris,
    String? description,
    String? clientUri,
    String? logoUri,
    String? privacyPolicyUrl,
    String? termsUrl,
    List<String>? contacts,
    String? tagline,
    List<String>? tags,
    List<String>? images,
    String? supportUrl,
    String? dataDeletionUrl,
    List<String>? postLogoutRedirectUris,
    bool? enabled,
    String? type,
    bool? deviceFlow,
    String? teamId,
  }) async {
    final String apiPath = '/apps';

    final Map<String, dynamic> apiParams = {
      'appId': appId,
      'name': name,
      if (description != null) 'description': description,
      if (clientUri != null) 'clientUri': clientUri,
      if (logoUri != null) 'logoUri': logoUri,
      if (privacyPolicyUrl != null) 'privacyPolicyUrl': privacyPolicyUrl,
      if (termsUrl != null) 'termsUrl': termsUrl,
      if (contacts != null) 'contacts': contacts,
      if (tagline != null) 'tagline': tagline,
      if (tags != null) 'tags': tags,
      if (images != null) 'images': images,
      if (supportUrl != null) 'supportUrl': supportUrl,
      if (dataDeletionUrl != null) 'dataDeletionUrl': dataDeletionUrl,
      'redirectUris': redirectUris,
      if (postLogoutRedirectUris != null)
        'postLogoutRedirectUris': postLogoutRedirectUris,
      if (enabled != null) 'enabled': enabled,
      if (type != null) 'type': type,
      if (deviceFlow != null) 'deviceFlow': deviceFlow,
      if (teamId != null) 'teamId': teamId,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.App.fromMap(res.data);
  }

  /// List scopes an application can request when installed on a team.
  Future<models.AppScopeList> listInstallationScopes() async {
    final String apiPath = '/apps/scopes/installations';

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.AppScopeList.fromMap(res.data);
  }

  /// List scopes an application can request during the OAuth2 flow.
  Future<models.AppScopeList> listOAuth2Scopes() async {
    final String apiPath = '/apps/scopes/oauth2';

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.AppScopeList.fromMap(res.data);
  }

  /// Get an application by its unique ID.
  Future<models.App> get({
    required String appId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    final String apiPath = '/apps/{appId}'.replaceAll(
      '{appId}',
      appId,
    );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.App.fromMap(res.data);
  }

  /// Update an application by its unique ID.
  Future<models.App> update({
    required String appId,
    required String name,
    String? description,
    String? clientUri,
    String? logoUri,
    String? privacyPolicyUrl,
    String? termsUrl,
    List<String>? contacts,
    String? tagline,
    List<String>? tags,
    List<String>? images,
    String? supportUrl,
    String? dataDeletionUrl,
    bool? enabled,
    List<String>? redirectUris,
    List<String>? postLogoutRedirectUris,
    String? type,
    bool? deviceFlow,
    List<String>? installationScopes,
    String? installationRedirectUrl,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    final String apiPath = '/apps/{appId}'.replaceAll(
      '{appId}',
      appId,
    );

    final Map<String, dynamic> apiParams = {
      'name': name,
      if (description != null) 'description': description,
      if (clientUri != null) 'clientUri': clientUri,
      if (logoUri != null) 'logoUri': logoUri,
      if (privacyPolicyUrl != null) 'privacyPolicyUrl': privacyPolicyUrl,
      if (termsUrl != null) 'termsUrl': termsUrl,
      if (contacts != null) 'contacts': contacts,
      if (tagline != null) 'tagline': tagline,
      if (tags != null) 'tags': tags,
      if (images != null) 'images': images,
      if (supportUrl != null) 'supportUrl': supportUrl,
      if (dataDeletionUrl != null) 'dataDeletionUrl': dataDeletionUrl,
      if (enabled != null) 'enabled': enabled,
      if (redirectUris != null) 'redirectUris': redirectUris,
      if (postLogoutRedirectUris != null)
        'postLogoutRedirectUris': postLogoutRedirectUris,
      if (type != null) 'type': type,
      if (deviceFlow != null) 'deviceFlow': deviceFlow,
      if (installationScopes != null) 'installationScopes': installationScopes,
      if (installationRedirectUrl != null)
        'installationRedirectUrl': installationRedirectUrl,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.put,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.App.fromMap(res.data);
  }

  /// Delete an application by its unique ID.
  Future delete({
    required String appId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    final String apiPath = '/apps/{appId}'.replaceAll(
      '{appId}',
      appId,
    );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.delete,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }

  /// List installations of an application. Requires an app key sent in the
  /// `X-Appwrite-Key` header alongside the `X-Appwrite-App` header, or a caller
  /// with update access to the app.
  Future<models.AppInstallationList> listInstallations({
    required String appId,
    List<String>? queries,
    bool? total,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    final String apiPath = '/apps/{appId}/installations'.replaceAll(
      '{appId}',
      appId,
    );

    final Map<String, dynamic> apiParams = {
      if (queries != null) 'queries': queries,
      if (total != null) 'total': total,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.AppInstallationList.fromMap(res.data);
  }

  /// Get an installation of an application by its unique ID. Requires an app key
  /// sent in the `X-Appwrite-Key` header alongside the `X-Appwrite-App` header,
  /// or a caller with update access to the app.
  Future<models.AppInstallation> getInstallation({
    required String appId,
    required String installationId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    if (installationId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "installationId"',
      );
    }

    final String apiPath = '/apps/{appId}/installations/{installationId}'
        .replaceAll(
          '{appId}',
          appId,
        )
        .replaceAll(
          '{installationId}',
          installationId,
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.AppInstallation.fromMap(res.data);
  }

  /// Delete an installation of an application by its unique ID. Requires a
  /// caller with update access to the app. Previously issued installation access
  /// tokens are revoked.
  Future deleteInstallation({
    required String appId,
    required String installationId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    if (installationId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "installationId"',
      );
    }

    final String apiPath = '/apps/{appId}/installations/{installationId}'
        .replaceAll(
          '{appId}',
          appId,
        )
        .replaceAll(
          '{installationId}',
          installationId,
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.delete,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }

  /// Create a token for an installation of an application. Requires an app key
  /// sent in the `X-Appwrite-Key` header alongside the `X-Appwrite-App` header,
  /// or a caller with update access to the app. The returned token carries the
  /// scopes and authorization details granted to the installation, and can be
  /// used as an `Authorization: Bearer` header everywhere OAuth2 access tokens
  /// are accepted. Multiple tokens can be active for the same installation at
  /// once; each token stays valid until it expires or the installation is
  /// updated or deleted.
  Future<models.Oauth2Token> createInstallationToken({
    required String appId,
    required String installationId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    if (installationId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "installationId"',
      );
    }

    final String apiPath = '/apps/{appId}/installations/{installationId}/tokens'
        .replaceAll(
          '{appId}',
          appId,
        )
        .replaceAll(
          '{installationId}',
          installationId,
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Oauth2Token.fromMap(res.data);
  }

  /// List app keys for an application.
  Future<models.AppKeyList> listKeys({
    required String appId,
    List<String>? queries,
    bool? total,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    final String apiPath = '/apps/{appId}/keys'.replaceAll(
      '{appId}',
      appId,
    );

    final Map<String, dynamic> apiParams = {
      if (queries != null) 'queries': queries,
      if (total != null) 'total': total,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.AppKeyList.fromMap(res.data);
  }

  /// Create a new app key for an application. App keys carry no scopes; send one
  /// in the `X-Appwrite-Key` header alongside the `X-Appwrite-App` header to
  /// list the application's installations and create installation access tokens.
  Future<models.AppKey> createKey({
    required String appId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    final String apiPath = '/apps/{appId}/keys'.replaceAll(
      '{appId}',
      appId,
    );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.AppKey.fromMap(res.data);
  }

  /// Get an app key by its unique ID.
  Future<models.AppKey> getKey({
    required String appId,
    required String keyId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    if (keyId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "keyId"',
      );
    }

    final String apiPath = '/apps/{appId}/keys/{keyId}'
        .replaceAll(
          '{appId}',
          appId,
        )
        .replaceAll(
          '{keyId}',
          keyId,
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.AppKey.fromMap(res.data);
  }

  /// Delete an app key by its unique ID.
  Future deleteKey({
    required String appId,
    required String keyId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    if (keyId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "keyId"',
      );
    }

    final String apiPath = '/apps/{appId}/keys/{keyId}'
        .replaceAll(
          '{appId}',
          appId,
        )
        .replaceAll(
          '{keyId}',
          keyId,
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.delete,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }

  /// List client secrets for an application.
  Future<models.AppSecretList> listSecrets({
    required String appId,
    List<String>? queries,
    bool? total,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    final String apiPath = '/apps/{appId}/secrets'.replaceAll(
      '{appId}',
      appId,
    );

    final Map<String, dynamic> apiParams = {
      if (queries != null) 'queries': queries,
      if (total != null) 'total': total,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.AppSecretList.fromMap(res.data);
  }

  /// Create a new client secret for an application.
  Future<models.AppSecretPlaintext> createSecret({
    required String appId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    final String apiPath = '/apps/{appId}/secrets'.replaceAll(
      '{appId}',
      appId,
    );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.AppSecretPlaintext.fromMap(res.data);
  }

  /// Get an application client secret by its unique ID.
  Future<models.AppSecret> getSecret({
    required String appId,
    required String secretId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    if (secretId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "secretId"',
      );
    }

    final String apiPath = '/apps/{appId}/secrets/{secretId}'
        .replaceAll(
          '{appId}',
          appId,
        )
        .replaceAll(
          '{secretId}',
          secretId,
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.AppSecret.fromMap(res.data);
  }

  /// Delete an application client secret by its unique ID.
  Future deleteSecret({
    required String appId,
    required String secretId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    if (secretId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "secretId"',
      );
    }

    final String apiPath = '/apps/{appId}/secrets/{secretId}'
        .replaceAll(
          '{appId}',
          appId,
        )
        .replaceAll(
          '{secretId}',
          secretId,
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.delete,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }

  /// Transfer an application to another team by its unique ID.
  Future<models.App> updateTeam({
    required String appId,
    required String teamId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    final String apiPath = '/apps/{appId}/team'.replaceAll(
      '{appId}',
      appId,
    );

    final Map<String, dynamic> apiParams = {
      'teamId': teamId,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.patch,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.App.fromMap(res.data);
  }

  /// Revoke all tokens for an application by its unique ID.
  Future deleteTokens({
    required String appId,
  }) async {
    if (appId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "appId"',
      );
    }

    final String apiPath = '/apps/{appId}/tokens'.replaceAll(
      '{appId}',
      appId,
    );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.delete,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }
}
