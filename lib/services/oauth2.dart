part of '../appwrite.dart';

/// The OAuth2 service allows you to authorize apps and issue standards-based
/// OAuth2 and OpenID Connect tokens.
class Oauth2 extends Service {
  /// Initializes a [Oauth2] service
  Oauth2(super.client);

  /// Approve an OAuth2 grant after the user gives consent. Returns the
  /// `redirectUrl` the end user should be sent to. The consent screen may
  /// optionally pass enriched `authorization_details` to record the concrete
  /// resources the user selected. You can pass Accept header of
  /// `application/json` to receive a JSON response instead of a redirect.
  Future<models.Oauth2Approve> approve({
    required String grantId,
    String? authorizationDetails,
    String? scope,
  }) async {
    final String apiPath = '/oauth2/{project_id}/approve'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      'grant_id': grantId,
      if (authorizationDetails != null)
        'authorization_details': authorizationDetails,
      if (scope != null) 'scope': scope,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Oauth2Approve.fromMap(res.data);
  }

  /// Begin the OAuth2 authorization flow. When called without a session, the
  /// user is redirected to the consent screen without grant ID. When called with
  /// a session, the redirect URL includes param for grant ID. You can pass
  /// Accept header of `application/json` to receive a JSON response instead of a
  /// redirect.
  Future<models.Oauth2Authorize> authorize({
    String? clientId,
    String? redirectUri,
    String? responseType,
    String? scope,
    String? state,
    String? nonce,
    String? codeChallenge,
    String? codeChallengeMethod,
    String? prompt,
    int? maxAge,
    String? authorizationDetails,
    String? resource,
    String? audience,
    String? requestUri,
  }) async {
    final String apiPath = '/oauth2/{project_id}/authorize'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      if (clientId != null) 'client_id': clientId,
      if (redirectUri != null) 'redirect_uri': redirectUri,
      if (responseType != null) 'response_type': responseType,
      if (scope != null) 'scope': scope,
      if (state != null) 'state': state,
      if (nonce != null) 'nonce': nonce,
      if (codeChallenge != null) 'code_challenge': codeChallenge,
      if (codeChallengeMethod != null)
        'code_challenge_method': codeChallengeMethod,
      if (prompt != null) 'prompt': prompt,
      if (maxAge != null) 'max_age': maxAge,
      if (authorizationDetails != null)
        'authorization_details': authorizationDetails,
      if (resource != null) 'resource': resource,
      if (audience != null) 'audience': audience,
      if (requestUri != null) 'request_uri': requestUri,
    };

    final Map<String, String> apiHeaders = {
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Oauth2Authorize.fromMap(res.data);
  }

  /// Begin the OAuth2 authorization flow. When called without a session, the
  /// user is redirected to the consent screen without grant ID. When called with
  /// a session, the redirect URL includes param for grant ID. You can pass
  /// Accept header of `application/json` to receive a JSON response instead of a
  /// redirect.
  Future<models.Oauth2Authorize> authorizePost({
    String? clientId,
    String? redirectUri,
    String? responseType,
    String? scope,
    String? state,
    String? nonce,
    String? codeChallenge,
    String? codeChallengeMethod,
    String? prompt,
    int? maxAge,
    String? authorizationDetails,
    String? resource,
    String? audience,
    String? requestUri,
  }) async {
    final String apiPath = '/oauth2/{project_id}/authorize'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      if (clientId != null) 'client_id': clientId,
      if (redirectUri != null) 'redirect_uri': redirectUri,
      if (responseType != null) 'response_type': responseType,
      if (scope != null) 'scope': scope,
      if (state != null) 'state': state,
      if (nonce != null) 'nonce': nonce,
      if (codeChallenge != null) 'code_challenge': codeChallenge,
      if (codeChallengeMethod != null)
        'code_challenge_method': codeChallengeMethod,
      if (prompt != null) 'prompt': prompt,
      if (maxAge != null) 'max_age': maxAge,
      if (authorizationDetails != null)
        'authorization_details': authorizationDetails,
      if (resource != null) 'resource': resource,
      if (audience != null) 'audience': audience,
      if (requestUri != null) 'request_uri': requestUri,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Oauth2Authorize.fromMap(res.data);
  }

  /// Start the OAuth2 Device Authorization Grant. Returns the device code, user
  /// code, verification URL, expiration, and polling interval.
  Future<models.Oauth2DeviceAuthorization> createDeviceAuthorization({
    String? clientId,
    String? scope,
    String? authorizationDetails,
    String? resource,
    String? audience,
  }) async {
    final String apiPath = '/oauth2/{project_id}/device_authorization'
        .replaceAll(
          '{project_id}',
          client.config['project'] ?? '',
        );

    final Map<String, dynamic> apiParams = {
      if (clientId != null) 'client_id': clientId,
      if (scope != null) 'scope': scope,
      if (authorizationDetails != null)
        'authorization_details': authorizationDetails,
      if (resource != null) 'resource': resource,
      if (audience != null) 'audience': audience,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Oauth2DeviceAuthorization.fromMap(res.data);
  }

  /// Exchange a device flow user code for an OAuth2 grant. The authenticated
  /// user is bound to the pending grant. Pass the returned grant ID to the get
  /// grant endpoint to render the consent screen, then to the approve or reject
  /// endpoint to complete the flow.
  Future<models.Oauth2Grant> createGrant({
    required String userCode,
  }) async {
    final String apiPath = '/oauth2/{project_id}/grants'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      'user_code': userCode,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Oauth2Grant.fromMap(res.data);
  }

  /// Get an OAuth2 grant by its ID. Used by the consent screen to display the
  /// details of the authorization the user is being asked to approve. A grant
  /// can only be read by the user it belongs to, or by server SDK.
  Future<models.Oauth2Grant> getGrant({
    required String grantId,
  }) async {
    if (grantId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "grantId"',
      );
    }

    final String apiPath = '/oauth2/{project_id}/grants/{grant_id}'
        .replaceAll(
          '{project_id}',
          client.config['project'] ?? '',
        )
        .replaceAll(
          '{grant_id}',
          grantId,
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Oauth2Grant.fromMap(res.data);
  }

  /// OpenID Connect RP-Initiated Logout. Ends the user session and revokes the
  /// tokens issued to the app identified by the `id_token_hint`, then redirects
  /// the user to `post_logout_redirect_uri` when it matches a URI registered on
  /// the app.
  Future logout({
    String? idTokenHint,
    String? logoutHint,
    String? clientId,
    String? postLogoutRedirectUri,
    String? state,
    String? uiLocales,
  }) async {
    final String apiPath = '/oauth2/{project_id}/logout'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      if (idTokenHint != null) 'id_token_hint': idTokenHint,
      if (logoutHint != null) 'logout_hint': logoutHint,
      if (clientId != null) 'client_id': clientId,
      if (postLogoutRedirectUri != null)
        'post_logout_redirect_uri': postLogoutRedirectUri,
      if (state != null) 'state': state,
      if (uiLocales != null) 'ui_locales': uiLocales,
    };

    final Map<String, String> apiHeaders = {
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }

  /// OpenID Connect RP-Initiated Logout. Ends the user session and revokes the
  /// tokens issued to the app identified by the `id_token_hint`, then redirects
  /// the user to `post_logout_redirect_uri` when it matches a URI registered on
  /// the app.
  Future logoutPost({
    String? idTokenHint,
    String? logoutHint,
    String? clientId,
    String? postLogoutRedirectUri,
    String? state,
    String? uiLocales,
  }) async {
    final String apiPath = '/oauth2/{project_id}/logout'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      if (idTokenHint != null) 'id_token_hint': idTokenHint,
      if (logoutHint != null) 'logout_hint': logoutHint,
      if (clientId != null) 'client_id': clientId,
      if (postLogoutRedirectUri != null)
        'post_logout_redirect_uri': postLogoutRedirectUri,
      if (state != null) 'state': state,
      if (uiLocales != null) 'ui_locales': uiLocales,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }

  /// List the organizations the OAuth2 access token can access. Resolves the
  /// token's `organization` authorization details, expanding the `*` wildcard
  /// into the concrete set of organizations the user can see.
  Future<models.Oauth2OrganizationList> listOrganizations({
    int? limit,
    int? offset,
    String? search,
  }) async {
    final String apiPath = '/oauth2/{project_id}/organizations'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (search != null) 'search': search,
    };

    final Map<String, String> apiHeaders = {
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Oauth2OrganizationList.fromMap(res.data);
  }

  /// Store an OAuth2 authorization request server-side and receive a short-lived
  /// request_uri handle for the authorize endpoint.
  Future<models.Oauth2PAR> createPAR({
    required String clientId,
    required String redirectUri,
    required String responseType,
    String? scope,
    String? state,
    String? nonce,
    String? codeChallenge,
    String? codeChallengeMethod,
    String? prompt,
    int? maxAge,
    String? authorizationDetails,
    String? resource,
    String? audience,
  }) async {
    final String apiPath = '/oauth2/{project_id}/par'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'response_type': responseType,
      if (scope != null) 'scope': scope,
      if (state != null) 'state': state,
      if (nonce != null) 'nonce': nonce,
      if (codeChallenge != null) 'code_challenge': codeChallenge,
      if (codeChallengeMethod != null)
        'code_challenge_method': codeChallengeMethod,
      if (prompt != null) 'prompt': prompt,
      if (maxAge != null) 'max_age': maxAge,
      if (authorizationDetails != null)
        'authorization_details': authorizationDetails,
      if (resource != null) 'resource': resource,
      if (audience != null) 'audience': audience,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Oauth2PAR.fromMap(res.data);
  }

  /// List the projects the OAuth2 access token can access. Resolves the token's
  /// `project` authorization details, expanding the `*` wildcard into the
  /// concrete set of projects the user can see.
  Future<models.Oauth2ProjectList> listProjects({
    int? limit,
    int? offset,
    String? search,
  }) async {
    final String apiPath = '/oauth2/{project_id}/projects'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (search != null) 'search': search,
    };

    final Map<String, String> apiHeaders = {
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Oauth2ProjectList.fromMap(res.data);
  }

  /// Reject an OAuth2 grant when the user denies consent. Returns the
  /// `redirectUrl` the end user should be sent to with an `access_denied` error.
  /// You can pass Accept header of `application/json` to receive a JSON response
  /// instead of a redirect.
  Future<models.Oauth2Reject> reject({
    required String grantId,
  }) async {
    final String apiPath = '/oauth2/{project_id}/reject'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      'grant_id': grantId,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Oauth2Reject.fromMap(res.data);
  }

  /// Revoke an OAuth2 access token or refresh token.
  Future revoke({
    required String token,
    String? tokenTypeHint,
    String? clientId,
    String? clientSecret,
  }) async {
    final String apiPath = '/oauth2/{project_id}/revoke'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      'token': token,
      if (tokenTypeHint != null) 'token_type_hint': tokenTypeHint,
      if (clientId != null) 'client_id': clientId,
      if (clientSecret != null) 'client_secret': clientSecret,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }

  /// Exchange an OAuth2 authorization code, refresh token, or device code for
  /// access and refresh tokens.
  Future<models.Oauth2Token> createToken({
    required String grantType,
    String? code,
    String? refreshToken,
    String? deviceCode,
    String? clientId,
    String? clientSecret,
    String? codeVerifier,
    String? redirectUri,
    String? resource,
    String? audience,
  }) async {
    final String apiPath = '/oauth2/{project_id}/token'.replaceAll(
      '{project_id}',
      client.config['project'] ?? '',
    );

    final Map<String, dynamic> apiParams = {
      'grant_type': grantType,
      if (code != null) 'code': code,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (deviceCode != null) 'device_code': deviceCode,
      if (clientId != null) 'client_id': clientId,
      if (clientSecret != null) 'client_secret': clientSecret,
      if (codeVerifier != null) 'code_verifier': codeVerifier,
      if (redirectUri != null) 'redirect_uri': redirectUri,
      if (resource != null) 'resource': resource,
      if (audience != null) 'audience': audience,
    };

    final Map<String, String> apiHeaders = {
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
}
