part of appwrite;

/// The Account service allows you to authenticate and manage a user account.
class Account extends Service {
    /// Initializes a [Account] service
    Account(super.client);

    /// Get account
    ///
    /// Get the currently logged in user.
    Future<models.User> get() async {
        const String apiPath = '/account';

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// Create account
    ///
    /// Use this endpoint to allow a new user to register a new account in your
    /// project. After the user registration completes successfully, you can use
    /// the
    /// [/account/verfication](https://appwrite.io/docs/references/cloud/client-web/account#createVerification)
    /// route to start verifying the user email address. To allow the new user to
    /// login to their new account, you need to create a new [account
    /// session](https://appwrite.io/docs/references/cloud/client-web/account#createEmailSession).
    Future<models.User> create({required String userId, required String email, required String password, String? name}) async {
        const String apiPath = '/account';

        final Map<String, dynamic> apiParams = {
            'userId': userId,
            'email': email,
            'password': password,
            'name': name,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// Update email
    ///
    /// Update currently logged in user account email address. After changing user
    /// address, the user confirmation status will get reset. A new confirmation
    /// email is not sent automatically however you can use the send confirmation
    /// email endpoint again to send the confirmation email. For security measures,
    /// user password is required to complete this request.
    /// This endpoint can also be used to convert an anonymous account to a normal
    /// one, by passing an email address and a new password.
    /// 
    Future<models.User> updateEmail({required String email, required String password}) async {
        const String apiPath = '/account/email';

        final Map<String, dynamic> apiParams = {
            'email': email,
            'password': password,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// List Identities
    ///
    /// Get the list of identities for the currently logged in user.
    Future<models.IdentityList> listIdentities({List<String>? queries}) async {
        const String apiPath = '/account/identities';

        final Map<String, dynamic> apiParams = {
            'queries': queries,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.IdentityList.fromMap(res.data);

    }

    /// Delete identity
    ///
    /// Delete an identity by its unique ID.
    Future deleteIdentity({required String identityId}) async {
        final String apiPath = '/account/identities/{identityId}'.replaceAll('{identityId}', identityId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

    }

    /// Create JWT
    ///
    /// Use this endpoint to create a JSON Web Token. You can use the resulting JWT
    /// to authenticate on behalf of the current user when working with the
    /// Appwrite server-side API and SDKs. The JWT secret is valid for 15 minutes
    /// from its creation and will be invalid if the user will logout in that time
    /// frame.
    Future<models.Jwt> createJWT() async {
        const String apiPath = '/account/jwt';

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Jwt.fromMap(res.data);

    }

    /// List logs
    ///
    /// Get the list of latest security activity logs for the currently logged in
    /// user. Each log returns user IP address, location and date and time of log.
    Future<models.LogList> listLogs({List<String>? queries}) async {
        const String apiPath = '/account/logs';

        final Map<String, dynamic> apiParams = {
            'queries': queries,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.LogList.fromMap(res.data);

    }

    /// Update MFA
    ///
    Future<models.User> updateMFA({required bool mfa}) async {
        const String apiPath = '/account/mfa';

        final Map<String, dynamic> apiParams = {
            'mfa': mfa,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// Create 2FA Challenge
    ///
    Future<models.MfaChallenge> create2FAChallenge({required enums.AuthenticationFactor factor}) async {
        const String apiPath = '/account/mfa/challenge';

        final Map<String, dynamic> apiParams = {
            'factor': factor,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.MfaChallenge.fromMap(res.data);

    }

    /// Create MFA Challenge (confirmation)
    ///
    Future updateChallenge({required String challengeId, required String otp}) async {
        const String apiPath = '/account/mfa/challenge';

        final Map<String, dynamic> apiParams = {
            'challengeId': challengeId,
            'otp': otp,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

    }

    /// List Factors
    ///
    Future<models.MfaFactors> listFactors() async {
        const String apiPath = '/account/mfa/factors';

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.MfaFactors.fromMap(res.data);

    }

    /// Add Authenticator
    ///
    Future<models.MfaType> addAuthenticator({required enums.AuthenticatorType type}) async {
        final String apiPath = '/account/mfa/{type}'.replaceAll('{type}', type);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.MfaType.fromMap(res.data);

    }

    /// Verify Authenticator
    ///
    Future<models.User> verifyAuthenticator({required enums.AuthenticatorType type, required String otp}) async {
        final String apiPath = '/account/mfa/{type}'.replaceAll('{type}', type);

        final Map<String, dynamic> apiParams = {
            'otp': otp,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// Delete Authenticator
    ///
    Future<models.User> deleteAuthenticator({required enums.AuthenticatorType type, required String otp}) async {
        final String apiPath = '/account/mfa/{type}'.replaceAll('{type}', type);

        final Map<String, dynamic> apiParams = {
            'otp': otp,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// Update name
    ///
    /// Update currently logged in user account name.
    Future<models.User> updateName({required String name}) async {
        const String apiPath = '/account/name';

        final Map<String, dynamic> apiParams = {
            'name': name,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// Update password
    ///
    /// Update currently logged in user password. For validation, user is required
    /// to pass in the new password, and the old password. For users created with
    /// OAuth, Team Invites and Magic URL, oldPassword is optional.
    Future<models.User> updatePassword({required String password, String? oldPassword}) async {
        const String apiPath = '/account/password';

        final Map<String, dynamic> apiParams = {
            'password': password,
            'oldPassword': oldPassword,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// Update phone
    ///
    /// Update the currently logged in user's phone number. After updating the
    /// phone number, the phone verification status will be reset. A confirmation
    /// SMS is not sent automatically, however you can use the [POST
    /// /account/verification/phone](https://appwrite.io/docs/references/cloud/client-web/account#createPhoneVerification)
    /// endpoint to send a confirmation SMS.
    Future<models.User> updatePhone({required String phone, required String password}) async {
        const String apiPath = '/account/phone';

        final Map<String, dynamic> apiParams = {
            'phone': phone,
            'password': password,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// Get account preferences
    ///
    /// Get the preferences as a key-value object for the currently logged in user.
    Future<models.Preferences> getPrefs() async {
        const String apiPath = '/account/prefs';

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Preferences.fromMap(res.data);

    }

    /// Update preferences
    ///
    /// Update currently logged in user account preferences. The object you pass is
    /// stored as is, and replaces any previous value. The maximum allowed prefs
    /// size is 64kB and throws error if exceeded.
    Future<models.User> updatePrefs({required Map prefs}) async {
        const String apiPath = '/account/prefs';

        final Map<String, dynamic> apiParams = {
            'prefs': prefs,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// Create password recovery
    ///
    /// Sends the user an email with a temporary secret key for password reset.
    /// When the user clicks the confirmation link he is redirected back to your
    /// app password reset URL with the secret key and email address values
    /// attached to the URL query string. Use the query string params to submit a
    /// request to the [PUT
    /// /account/recovery](https://appwrite.io/docs/references/cloud/client-web/account#updateRecovery)
    /// endpoint to complete the process. The verification link sent to the user's
    /// email address is valid for 1 hour.
    Future<models.Token> createRecovery({required String email, required String url}) async {
        const String apiPath = '/account/recovery';

        final Map<String, dynamic> apiParams = {
            'email': email,
            'url': url,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Token.fromMap(res.data);

    }

    /// Create password recovery (confirmation)
    ///
    /// Use this endpoint to complete the user account password reset. Both the
    /// **userId** and **secret** arguments will be passed as query parameters to
    /// the redirect URL you have provided when sending your request to the [POST
    /// /account/recovery](https://appwrite.io/docs/references/cloud/client-web/account#createRecovery)
    /// endpoint.
    /// 
    /// Please note that in order to avoid a [Redirect
    /// Attack](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.md)
    /// the only valid redirect URLs are the ones from domains you have set when
    /// adding your platforms in the console interface.
    Future<models.Token> updateRecovery({required String userId, required String secret, required String password}) async {
        const String apiPath = '/account/recovery';

        final Map<String, dynamic> apiParams = {
            'userId': userId,
            'secret': secret,
            'password': password,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Token.fromMap(res.data);

    }

    /// List sessions
    ///
    /// Get the list of active sessions across different devices for the currently
    /// logged in user.
    Future<models.SessionList> listSessions() async {
        const String apiPath = '/account/sessions';

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.SessionList.fromMap(res.data);

    }

    /// Delete sessions
    ///
    /// Delete all sessions from the user account and remove any sessions cookies
    /// from the end client.
    Future deleteSessions() async {
        const String apiPath = '/account/sessions';

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

    }

    /// Create anonymous session
    ///
    /// Use this endpoint to allow a new user to register an anonymous account in
    /// your project. This route will also create a new session for the user. To
    /// allow the new user to convert an anonymous account to a normal account, you
    /// need to update its [email and
    /// password](https://appwrite.io/docs/references/cloud/client-web/account#updateEmail)
    /// or create an [OAuth2
    /// session](https://appwrite.io/docs/references/cloud/client-web/account#CreateOAuth2Session).
    Future<models.Session> createAnonymousSession() async {
        const String apiPath = '/account/sessions/anonymous';

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Session.fromMap(res.data);

    }

    /// Create email password session
    ///
    /// Allow the user to login into their account by providing a valid email and
    /// password combination. This route will create a new session for the user.
    /// 
    /// A user is limited to 10 active sessions at a time by default. [Learn more
    /// about session
    /// limits](https://appwrite.io/docs/authentication-security#limits).
    Future<models.Session> createEmailPasswordSession({required String email, required String password}) async {
        const String apiPath = '/account/sessions/email';

        final Map<String, dynamic> apiParams = {
            'email': email,
            'password': password,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Session.fromMap(res.data);

    }

    /// Create session (deprecated)
    ///
    /// Use this endpoint to create a session from token. Provide the **userId**
    /// and **secret** parameters from the successful response of authentication
    /// flows initiated by token creation. For example, magic URL and phone login.
    Future<models.Session> updateMagicURLSession({required String userId, required String secret}) async {
        const String apiPath = '/account/sessions/magic-url';

        final Map<String, dynamic> apiParams = {
            'userId': userId,
            'secret': secret,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Session.fromMap(res.data);

    }

    /// Create OAuth2 session
    ///
    /// Allow the user to login to their account using the OAuth2 provider of their
    /// choice. Each OAuth2 provider should be enabled from the Appwrite console
    /// first. Use the success and failure arguments to provide a redirect URL's
    /// back to your app when login is completed.
    /// 
    /// If there is already an active session, the new session will be attached to
    /// the logged-in account. If there are no active sessions, the server will
    /// attempt to look for a user with the same email address as the email
    /// received from the OAuth2 provider and attach the new session to the
    /// existing user. If no matching user is found - the server will create a new
    /// user.
    /// 
    /// A user is limited to 10 active sessions at a time by default. [Learn more
    /// about session
    /// limits](https://appwrite.io/docs/authentication-security#limits).
    /// 
    Future createOAuth2Session({required enums.OAuthProvider provider, String? success, String? failure, bool? token, List<String>? scopes}) async {
        final String apiPath = '/account/sessions/oauth2/{provider}'.replaceAll('{provider}', provider);

        final Map<String, dynamic> params = {
            
            'success': success,
            'failure': failure,
            'token': token,
            'scopes': scopes,
            
            'project': client.config['project'],
        };

        final List query = [];

        params.forEach((key, value) {
          if (value is List) { 
            for (var item in value) {
              query.add(Uri.encodeComponent(key + '[]') + '=' + Uri.encodeComponent(item));
            }
          } else if(value != null) {
              query.add(Uri.encodeComponent(key) + '=' + Uri.encodeComponent(value));
          }
        });

        Uri endpoint = Uri.parse(client.endPoint);
        Uri url = Uri(scheme: endpoint.scheme,
          host: endpoint.host,
          port: endpoint.port,
          path: endpoint.path + apiPath,
          query: query.join('&')
        );

      return client.webAuth(url, callbackUrlScheme: success);
    }

    /// Create session
    ///
    /// Use this endpoint to create a session from token. Provide the **userId**
    /// and **secret** parameters from the successful response of authentication
    /// flows initiated by token creation. For example, magic URL and phone login.
    Future<models.Session> createSession({required String userId, required String secret}) async {
        const String apiPath = '/account/sessions/token';

        final Map<String, dynamic> apiParams = {
            'userId': userId,
            'secret': secret,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Session.fromMap(res.data);

    }

    /// Get session
    ///
    /// Use this endpoint to get a logged in user's session using a Session ID.
    /// Inputting 'current' will return the current session being used.
    Future<models.Session> getSession({required String sessionId}) async {
        final String apiPath = '/account/sessions/{sessionId}'.replaceAll('{sessionId}', sessionId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Session.fromMap(res.data);

    }

    /// Update (or renew) a session
    ///
    /// Extend session's expiry to increase it's lifespan. Extending a session is
    /// useful when session length is short such as 5 minutes.
    Future<models.Session> updateSession({required String sessionId}) async {
        final String apiPath = '/account/sessions/{sessionId}'.replaceAll('{sessionId}', sessionId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Session.fromMap(res.data);

    }

    /// Delete session
    ///
    /// Logout the user. Use 'current' as the session ID to logout on this device,
    /// use a session ID to logout on another device. If you're looking to logout
    /// the user on all devices, use [Delete
    /// Sessions](https://appwrite.io/docs/references/cloud/client-web/account#deleteSessions)
    /// instead.
    Future deleteSession({required String sessionId}) async {
        final String apiPath = '/account/sessions/{sessionId}'.replaceAll('{sessionId}', sessionId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

    }

    /// Update status
    ///
    /// Block the currently logged in user account. Behind the scene, the user
    /// record is not deleted but permanently blocked from any access. To
    /// completely delete a user, use the Users API instead.
    Future<models.User> updateStatus() async {
        const String apiPath = '/account/status';

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// Create a push target
    ///
    Future<models.Target> createPushTarget({required String targetId, required String identifier, String? providerId}) async {
        const String apiPath = '/account/targets/push';

        final Map<String, dynamic> apiParams = {
            'targetId': targetId,
            'identifier': identifier,
            'providerId': providerId,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Target.fromMap(res.data);

    }

    /// Update a push target
    ///
    Future<models.Target> updatePushTarget({required String targetId, required String identifier}) async {
        final String apiPath = '/account/targets/{targetId}/push'.replaceAll('{targetId}', targetId);

        final Map<String, dynamic> apiParams = {
            'identifier': identifier,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Target.fromMap(res.data);

    }

    /// Delete a push target
    ///
    Future deletePushTarget({required String targetId}) async {
        final String apiPath = '/account/targets/{targetId}/push'.replaceAll('{targetId}', targetId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

    }

    /// Create email token (OTP)
    ///
    /// Sends the user an email with a secret key for creating a session. If the
    /// provided user ID has not be registered, a new user will be created. Use the
    /// returned user ID and secret and submit a request to the [POST
    /// /v1/account/sessions/token](https://appwrite.io/docs/references/cloud/client-web/account#createSession)
    /// endpoint to complete the login process. The secret sent to the user's email
    /// is valid for 15 minutes.
    /// 
    /// A user is limited to 10 active sessions at a time by default. [Learn more
    /// about session
    /// limits](https://appwrite.io/docs/authentication-security#limits).
    Future<models.Token> createEmailToken({required String userId, required String email, bool? phrase}) async {
        const String apiPath = '/account/tokens/email';

        final Map<String, dynamic> apiParams = {
            'userId': userId,
            'email': email,
            'phrase': phrase,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Token.fromMap(res.data);

    }

    /// Create magic URL token
    ///
    /// Sends the user an email with a secret key for creating a session. If the
    /// provided user ID has not been registered, a new user will be created. When
    /// the user clicks the link in the email, the user is redirected back to the
    /// URL you provided with the secret key and userId values attached to the URL
    /// query string. Use the query string parameters to submit a request to the
    /// [POST
    /// /v1/account/sessions/token](https://appwrite.io/docs/references/cloud/client-web/account#createSession)
    /// endpoint to complete the login process. The link sent to the user's email
    /// address is valid for 1 hour. If you are on a mobile device you can leave
    /// the URL parameter empty, so that the login completion will be handled by
    /// your Appwrite instance by default.
    /// 
    /// A user is limited to 10 active sessions at a time by default. [Learn more
    /// about session
    /// limits](https://appwrite.io/docs/authentication-security#limits).
    /// 
    Future<models.Token> createMagicURLToken({required String userId, required String email, String? url, bool? phrase}) async {
        const String apiPath = '/account/tokens/magic-url';

        final Map<String, dynamic> apiParams = {
            'userId': userId,
            'email': email,
            'url': url,
            'phrase': phrase,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Token.fromMap(res.data);

    }

    /// Create phone token
    ///
    /// Sends the user an SMS with a secret key for creating a session. If the
    /// provided user ID has not be registered, a new user will be created. Use the
    /// returned user ID and secret and submit a request to the [POST
    /// /v1/account/sessions/token](https://appwrite.io/docs/references/cloud/client-web/account#createSession)
    /// endpoint to complete the login process. The secret sent to the user's phone
    /// is valid for 15 minutes.
    /// 
    /// A user is limited to 10 active sessions at a time by default. [Learn more
    /// about session
    /// limits](https://appwrite.io/docs/authentication-security#limits).
    Future<models.Token> createPhoneToken({required String userId, required String phone}) async {
        const String apiPath = '/account/tokens/phone';

        final Map<String, dynamic> apiParams = {
            'userId': userId,
            'phone': phone,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Token.fromMap(res.data);

    }

    /// Create email verification
    ///
    /// Use this endpoint to send a verification message to your user email address
    /// to confirm they are the valid owners of that address. Both the **userId**
    /// and **secret** arguments will be passed as query parameters to the URL you
    /// have provided to be attached to the verification email. The provided URL
    /// should redirect the user back to your app and allow you to complete the
    /// verification process by verifying both the **userId** and **secret**
    /// parameters. Learn more about how to [complete the verification
    /// process](https://appwrite.io/docs/references/cloud/client-web/account#updateVerification).
    /// The verification link sent to the user's email address is valid for 7 days.
    /// 
    /// Please note that in order to avoid a [Redirect
    /// Attack](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.md),
    /// the only valid redirect URLs are the ones from domains you have set when
    /// adding your platforms in the console interface.
    /// 
    Future<models.Token> createVerification({required String url}) async {
        const String apiPath = '/account/verification';

        final Map<String, dynamic> apiParams = {
            'url': url,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Token.fromMap(res.data);

    }

    /// Create email verification (confirmation)
    ///
    /// Use this endpoint to complete the user email verification process. Use both
    /// the **userId** and **secret** parameters that were attached to your app URL
    /// to verify the user email ownership. If confirmed this route will return a
    /// 200 status code.
    Future<models.Token> updateVerification({required String userId, required String secret}) async {
        const String apiPath = '/account/verification';

        final Map<String, dynamic> apiParams = {
            'userId': userId,
            'secret': secret,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Token.fromMap(res.data);

    }

    /// Create phone verification
    ///
    /// Use this endpoint to send a verification SMS to the currently logged in
    /// user. This endpoint is meant for use after updating a user's phone number
    /// using the
    /// [accountUpdatePhone](https://appwrite.io/docs/references/cloud/client-web/account#updatePhone)
    /// endpoint. Learn more about how to [complete the verification
    /// process](https://appwrite.io/docs/references/cloud/client-web/account#updatePhoneVerification).
    /// The verification code sent to the user's phone number is valid for 15
    /// minutes.
    Future<models.Token> createPhoneVerification() async {
        const String apiPath = '/account/verification/phone';

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Token.fromMap(res.data);

    }

    /// Create phone verification (confirmation)
    ///
    /// Use this endpoint to complete the user phone verification process. Use the
    /// **userId** and **secret** that were sent to your user's phone number to
    /// verify the user email ownership. If confirmed this route will return a 200
    /// status code.
    Future<models.Token> updatePhoneVerification({required String userId, required String secret}) async {
        const String apiPath = '/account/verification/phone';

        final Map<String, dynamic> apiParams = {
            'userId': userId,
            'secret': secret,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Token.fromMap(res.data);

    }
}