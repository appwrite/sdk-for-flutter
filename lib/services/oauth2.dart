part of '../appwrite.dart';

class Oauth2 extends Service {
  /// Initializes a [Oauth2] service
  Oauth2(super.client);

  /// Approve an OAuth2 grant after the user gives consent. Returns the
  /// `redirectUrl` the end user should be sent to. The consent screen may
  /// optionally pass enriched `authorization_details` to record the concrete
  /// resources the user selected. You can pass Accept header of
  /// `application/json` to receive a JSON response instead of a redirect.
  Future<models.Oauth2Approve> approve(
      {required String projectId,
      required String grantId,
      String? authorizationDetails}) async {
    final String apiPath =
        '/oauth2/{project_id}/approve'.replaceAll('{project_id}', projectId) +
            '?project=${Uri.encodeComponent(client.config['project'] ?? '')}';

    final Map<String, dynamic> apiParams = {
      'grant_id': grantId,
      if (authorizationDetails != null)
        'authorization_details': authorizationDetails,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(HttpMethod.post,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Oauth2Approve.fromMap(res.data);
  }

  /// Begin the OAuth2 authorization flow. When called without a session, the
  /// user is redirected to the consent screen without grant ID. When called with
  /// a session, the redirect URL includes param for grant ID. You can pass
  /// Accept header of `application/json` to receive a JSON response instead of a
  /// redirect.
  Future<models.Oauth2Authorize> authorize(
      {required String projectId,
      required String clientId,
      required String redirectUri,
      required String responseType,
      required String scope,
      String? state,
      String? nonce,
      String? codeChallenge,
      String? codeChallengeMethod,
      String? prompt,
      int? maxAge,
      String? authorizationDetails}) async {
    final String apiPath =
        '/oauth2/{project_id}/authorize'.replaceAll('{project_id}', projectId) +
            '?project=${Uri.encodeComponent(client.config['project'] ?? '')}';

    final Map<String, dynamic> apiParams = {
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'response_type': responseType,
      'scope': scope,
      if (state != null) 'state': state,
      if (nonce != null) 'nonce': nonce,
      if (codeChallenge != null) 'code_challenge': codeChallenge,
      if (codeChallengeMethod != null)
        'code_challenge_method': codeChallengeMethod,
      if (prompt != null) 'prompt': prompt,
      if (maxAge != null) 'max_age': maxAge,
      if (authorizationDetails != null)
        'authorization_details': authorizationDetails,
    };

    final Map<String, String> apiHeaders = {
      'accept': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Oauth2Authorize.fromMap(res.data);
  }

  /// Exchange a device flow user code for an OAuth2 grant. The authenticated
  /// user is bound to the pending grant. Pass the returned grant ID to the get
  /// grant endpoint to render the consent screen, then to the approve or reject
  /// endpoint to complete the flow.
  Future<models.Oauth2Grant> createGrant(
      {required String projectId, required String userCode}) async {
    final String apiPath =
        '/oauth2/{project_id}/grants'.replaceAll('{project_id}', projectId);

    final Map<String, dynamic> apiParams = {
      'user_code': userCode,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(HttpMethod.post,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Oauth2Grant.fromMap(res.data);
  }

  /// Get an OAuth2 grant by its ID. Used by the consent screen to display the
  /// details of the authorization the user is being asked to approve. A grant
  /// can only be read by the user it belongs to, or by server SDK.
  Future<models.Oauth2Grant> getGrant(
      {required String projectId, required String grantId}) async {
    final String apiPath = '/oauth2/{project_id}/grants/{grant_id}'
        .replaceAll('{project_id}', projectId)
        .replaceAll('{grant_id}', grantId);

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Oauth2Grant.fromMap(res.data);
  }

  /// Reject an OAuth2 grant when the user denies consent. Returns the
  /// `redirectUrl` the end user should be sent to with an `access_denied` error.
  /// You can pass Accept header of `application/json` to receive a JSON response
  /// instead of a redirect.
  Future<models.Oauth2Reject> reject(
      {required String projectId, required String grantId}) async {
    final String apiPath =
        '/oauth2/{project_id}/reject'.replaceAll('{project_id}', projectId) +
            '?project=${Uri.encodeComponent(client.config['project'] ?? '')}';

    final Map<String, dynamic> apiParams = {
      'grant_id': grantId,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(HttpMethod.post,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Oauth2Reject.fromMap(res.data);
  }
}
