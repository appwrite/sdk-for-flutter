part of appwrite;

// access Account without conflicting namespaces
typedef AccountService = Account;

    /// The Account service allows you to authenticate and manage a user account.
class Account extends Service {
    Account(super.client);

    /// Get Account
    ///
    /// Get currently logged in user data as JSON object.
    ///
    Future<models.Account> get() async {
        const String path = '/account';

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.Account.fromMap(res.data);

    }

    /// Create Account
    ///
    /// Use this endpoint to allow a new user to register a new account in your
    /// project. After the user registration completes successfully, you can use
    /// the [/account/verfication](/docs/client/account#accountCreateVerification)
    /// route to start verifying the user email address. To allow the new user to
    /// login to their new account, you need to create a new [account
    /// session](/docs/client/account#accountCreateSession).
    ///
    Future<models.Account> create({required String userId, required String email, required String password, String? name}) async {
        const String path = '/account';

        final Map<String, dynamic> params = {
            'userId': userId,
            'email': email,
            'password': password,
            'name': name,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Account.fromMap(res.data);

    }

    /// Update Email
    ///
    /// Update currently logged in user account email address. After changing user
    /// address, the user confirmation status will get reset. A new confirmation
    /// email is not sent automatically however you can use the send confirmation
    /// email endpoint again to send the confirmation email. For security measures,
    /// user password is required to complete this request.
    /// This endpoint can also be used to convert an anonymous account to a normal
    /// one, by passing an email address and a new password.
    /// 
    ///
    Future<models.Account> updateEmail({required String email, required String password}) async {
        const String path = '/account/email';

        final Map<String, dynamic> params = {
            'email': email,
            'password': password,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: path, params: params, headers: headers);

        return models.Account.fromMap(res.data);

    }

    /// Create JWT
    ///
    /// Use this endpoint to create a JSON Web Token. You can use the resulting JWT
    /// to authenticate on behalf of the current user when working with the
    /// Appwrite server-side API and SDKs. The JWT secret is valid for 15 minutes
    /// from its creation and will be invalid if the user will logout in that time
    /// frame.
    ///
    Future<models.Jwt> createJWT() async {
        const String path = '/account/jwt';

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Jwt.fromMap(res.data);

    }

    /// List Logs
    ///
    /// Get currently logged in user list of latest security activity logs. Each
    /// log returns user IP address, location and date and time of log.
    ///
    Future<models.LogList> listLogs({List<String>? queries}) async {
        const String path = '/account/logs';

        final Map<String, dynamic> params = {
            'queries': queries,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.LogList.fromMap(res.data);

    }

    /// Update Name
    ///
    /// Update currently logged in user account name.
    ///
    Future<models.Account> updateName({required String name}) async {
        const String path = '/account/name';

        final Map<String, dynamic> params = {
            'name': name,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: path, params: params, headers: headers);

        return models.Account.fromMap(res.data);

    }

    /// Update Password
    ///
    /// Update currently logged in user password. For validation, user is required
    /// to pass in the new password, and the old password. For users created with
    /// OAuth, Team Invites and Magic URL, oldPassword is optional.
    ///
    Future<models.Account> updatePassword({required String password, String? oldPassword}) async {
        const String path = '/account/password';

        final Map<String, dynamic> params = {
            'password': password,
            'oldPassword': oldPassword,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: path, params: params, headers: headers);

        return models.Account.fromMap(res.data);

    }

    /// Update Phone
    ///
    /// Update the currently logged in user's phone number. After updating the
    /// phone number, the phone verification status will be reset. A confirmation
    /// SMS is not sent automatically, however you can use the [POST
    /// /account/verification/phone](/docs/client/account#accountCreatePhoneVerification)
    /// endpoint to send a confirmation SMS.
    ///
    Future<models.Account> updatePhone({required String phone, required String password}) async {
        const String path = '/account/phone';

        final Map<String, dynamic> params = {
            'phone': phone,
            'password': password,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: path, params: params, headers: headers);

        return models.Account.fromMap(res.data);

    }

    /// Get Account Preferences
    ///
    /// Get currently logged in user preferences as a key-value object.
    ///
    Future<models.Preferences> getPrefs() async {
        const String path = '/account/prefs';

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.Preferences.fromMap(res.data);

    }

    /// Update Preferences
    ///
    /// Update currently logged in user account preferences. The object you pass is
    /// stored as is, and replaces any previous value. The maximum allowed prefs
    /// size is 64kB and throws error if exceeded.
    ///
    Future<models.Account> updatePrefs({required Map prefs}) async {
        const String path = '/account/prefs';

        final Map<String, dynamic> params = {
            'prefs': prefs,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: path, params: params, headers: headers);

        return models.Account.fromMap(res.data);

    }

    /// Create Password Recovery
    ///
    /// Sends the user an email with a temporary secret key for password reset.
    /// When the user clicks the confirmation link he is redirected back to your
    /// app password reset URL with the secret key and email address values
    /// attached to the URL query string. Use the query string params to submit a
    /// request to the [PUT
    /// /account/recovery](/docs/client/account#accountUpdateRecovery) endpoint to
    /// complete the process. The verification link sent to the user's email
    /// address is valid for 1 hour.
    ///
    Future<models.Token> createRecovery({required String email, required String url}) async {
        const String path = '/account/recovery';

        final Map<String, dynamic> params = {
            'email': email,
            'url': url,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Token.fromMap(res.data);

    }

    /// Create Password Recovery (confirmation)
    ///
    /// Use this endpoint to complete the user account password reset. Both the
    /// **userId** and **secret** arguments will be passed as query parameters to
    /// the redirect URL you have provided when sending your request to the [POST
    /// /account/recovery](/docs/client/account#accountCreateRecovery) endpoint.
    /// 
    /// Please note that in order to avoid a [Redirect
    /// Attack](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.md)
    /// the only valid redirect URLs are the ones from domains you have set when
    /// adding your platforms in the console interface.
    ///
    Future<models.Token> updateRecovery({required String userId, required String secret, required String password, required String passwordAgain}) async {
        const String path = '/account/recovery';

        final Map<String, dynamic> params = {
            'userId': userId,
            'secret': secret,
            'password': password,
            'passwordAgain': passwordAgain,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: path, params: params, headers: headers);

        return models.Token.fromMap(res.data);

    }

    /// List Sessions
    ///
    /// Get currently logged in user list of active sessions across different
    /// devices.
    ///
    Future<models.SessionList> listSessions() async {
        const String path = '/account/sessions';

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.SessionList.fromMap(res.data);

    }

    /// Delete Sessions
    ///
    /// Delete all sessions from the user account and remove any sessions cookies
    /// from the end client.
    ///
    Future deleteSessions() async {
        const String path = '/account/sessions';

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: path, params: params, headers: headers);

        return  res.data;

    }

    /// Create Anonymous Session
    ///
    /// Use this endpoint to allow a new user to register an anonymous account in
    /// your project. This route will also create a new session for the user. To
    /// allow the new user to convert an anonymous account to a normal account, you
    /// need to update its [email and
    /// password](/docs/client/account#accountUpdateEmail) or create an [OAuth2
    /// session](/docs/client/account#accountCreateOAuth2Session).
    ///
    Future<models.Session> createAnonymousSession() async {
        const String path = '/account/sessions/anonymous';

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Session.fromMap(res.data);

    }

    /// Create Email Session
    ///
    /// Allow the user to login into their account by providing a valid email and
    /// password combination. This route will create a new session for the user.
    /// 
    /// A user is limited to 10 active sessions at a time by default. [Learn more
    /// about session limits](/docs/authentication#limits).
    ///
    Future<models.Session> createEmailSession({required String email, required String password}) async {
        const String path = '/account/sessions/email';

        final Map<String, dynamic> params = {
            'email': email,
            'password': password,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Session.fromMap(res.data);

    }

    /// Create Magic URL session
    ///
    /// Sends the user an email with a secret key for creating a session. If the
    /// provided user ID has not be registered, a new user will be created. When
    /// the user clicks the link in the email, the user is redirected back to the
    /// URL you provided with the secret key and userId values attached to the URL
    /// query string. Use the query string parameters to submit a request to the
    /// [PUT
    /// /account/sessions/magic-url](/docs/client/account#accountUpdateMagicURLSession)
    /// endpoint to complete the login process. The link sent to the user's email
    /// address is valid for 1 hour. If you are on a mobile device you can leave
    /// the URL parameter empty, so that the login completion will be handled by
    /// your Appwrite instance by default.
    /// 
    /// A user is limited to 10 active sessions at a time by default. [Learn more
    /// about session limits](/docs/authentication#limits).
    ///
    Future<models.Token> createMagicURLSession({required String userId, required String email, String? url}) async {
        const String path = '/account/sessions/magic-url';

        final Map<String, dynamic> params = {
            'userId': userId,
            'email': email,
            'url': url,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Token.fromMap(res.data);

    }

    /// Create Magic URL session (confirmation)
    ///
    /// Use this endpoint to complete creating the session with the Magic URL. Both
    /// the **userId** and **secret** arguments will be passed as query parameters
    /// to the redirect URL you have provided when sending your request to the
    /// [POST
    /// /account/sessions/magic-url](/docs/client/account#accountCreateMagicURLSession)
    /// endpoint.
    /// 
    /// Please note that in order to avoid a [Redirect
    /// Attack](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.md)
    /// the only valid redirect URLs are the ones from domains you have set when
    /// adding your platforms in the console interface.
    ///
    Future<models.Session> updateMagicURLSession({required String userId, required String secret}) async {
        const String path = '/account/sessions/magic-url';

        final Map<String, dynamic> params = {
            'userId': userId,
            'secret': secret,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: path, params: params, headers: headers);

        return models.Session.fromMap(res.data);

    }

    /// Create OAuth2 Session
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
    /// about session limits](/docs/authentication#limits).
    /// 
    ///
    Future createOAuth2Session({required String provider, String? success, String? failure, List<String>? scopes}) async {
        final String path = '/account/sessions/oauth2/{provider}'.replaceAll('{provider}', provider);

        final Map<String, dynamic> params = {
            
            'success': success,
            'failure': failure,
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
          path: endpoint.path + path,
          query: query.join('&')
        );

      return client.webAuth(url, callbackUrlScheme: success);
    }

    /// Create Phone session
    ///
    /// Sends the user an SMS with a secret key for creating a session. If the
    /// provided user ID has not be registered, a new user will be created. Use the
    /// returned user ID and secret and submit a request to the [PUT
    /// /account/sessions/phone](/docs/client/account#accountUpdatePhoneSession)
    /// endpoint to complete the login process. The secret sent to the user's phone
    /// is valid for 15 minutes.
    /// 
    /// A user is limited to 10 active sessions at a time by default. [Learn more
    /// about session limits](/docs/authentication#limits).
    ///
    Future<models.Token> createPhoneSession({required String userId, required String phone}) async {
        const String path = '/account/sessions/phone';

        final Map<String, dynamic> params = {
            'userId': userId,
            'phone': phone,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Token.fromMap(res.data);

    }

    /// Create Phone Session (confirmation)
    ///
    /// Use this endpoint to complete creating a session with SMS. Use the
    /// **userId** from the
    /// [createPhoneSession](/docs/client/account#accountCreatePhoneSession)
    /// endpoint and the **secret** received via SMS to successfully update and
    /// confirm the phone session.
    ///
    Future<models.Session> updatePhoneSession({required String userId, required String secret}) async {
        const String path = '/account/sessions/phone';

        final Map<String, dynamic> params = {
            'userId': userId,
            'secret': secret,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: path, params: params, headers: headers);

        return models.Session.fromMap(res.data);

    }

    /// Get Session
    ///
    /// Use this endpoint to get a logged in user's session using a Session ID.
    /// Inputting 'current' will return the current session being used.
    ///
    Future<models.Session> getSession({required String sessionId}) async {
        final String path = '/account/sessions/{sessionId}'.replaceAll('{sessionId}', sessionId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.Session.fromMap(res.data);

    }

    /// Update OAuth Session (Refresh Tokens)
    ///
    /// Access tokens have limited lifespan and expire to mitigate security risks.
    /// If session was created using an OAuth provider, this route can be used to
    /// "refresh" the access token.
    ///
    Future<models.Session> updateSession({required String sessionId}) async {
        final String path = '/account/sessions/{sessionId}'.replaceAll('{sessionId}', sessionId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: path, params: params, headers: headers);

        return models.Session.fromMap(res.data);

    }

    /// Delete Session
    ///
    /// Use this endpoint to log out the currently logged in user from all their
    /// account sessions across all of their different devices. When using the
    /// Session ID argument, only the unique session ID provided is deleted.
    /// 
    ///
    Future deleteSession({required String sessionId}) async {
        final String path = '/account/sessions/{sessionId}'.replaceAll('{sessionId}', sessionId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: path, params: params, headers: headers);

        return  res.data;

    }

    /// Update Status
    ///
    /// Block the currently logged in user account. Behind the scene, the user
    /// record is not deleted but permanently blocked from any access. To
    /// completely delete a user, use the Users API instead.
    ///
    Future<models.Account> updateStatus() async {
        const String path = '/account/status';

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: path, params: params, headers: headers);

        return models.Account.fromMap(res.data);

    }

    /// Create Email Verification
    ///
    /// Use this endpoint to send a verification message to your user email address
    /// to confirm they are the valid owners of that address. Both the **userId**
    /// and **secret** arguments will be passed as query parameters to the URL you
    /// have provided to be attached to the verification email. The provided URL
    /// should redirect the user back to your app and allow you to complete the
    /// verification process by verifying both the **userId** and **secret**
    /// parameters. Learn more about how to [complete the verification
    /// process](/docs/client/account#accountUpdateEmailVerification). The
    /// verification link sent to the user's email address is valid for 7 days.
    /// 
    /// Please note that in order to avoid a [Redirect
    /// Attack](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.md),
    /// the only valid redirect URLs are the ones from domains you have set when
    /// adding your platforms in the console interface.
    /// 
    ///
    Future<models.Token> createVerification({required String url}) async {
        const String path = '/account/verification';

        final Map<String, dynamic> params = {
            'url': url,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Token.fromMap(res.data);

    }

    /// Create Email Verification (confirmation)
    ///
    /// Use this endpoint to complete the user email verification process. Use both
    /// the **userId** and **secret** parameters that were attached to your app URL
    /// to verify the user email ownership. If confirmed this route will return a
    /// 200 status code.
    ///
    Future<models.Token> updateVerification({required String userId, required String secret}) async {
        const String path = '/account/verification';

        final Map<String, dynamic> params = {
            'userId': userId,
            'secret': secret,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: path, params: params, headers: headers);

        return models.Token.fromMap(res.data);

    }

    /// Create Phone Verification
    ///
    /// Use this endpoint to send a verification SMS to the currently logged in
    /// user. This endpoint is meant for use after updating a user's phone number
    /// using the [accountUpdatePhone](/docs/client/account#accountUpdatePhone)
    /// endpoint. Learn more about how to [complete the verification
    /// process](/docs/client/account#accountUpdatePhoneVerification). The
    /// verification code sent to the user's phone number is valid for 15 minutes.
    ///
    Future<models.Token> createPhoneVerification() async {
        const String path = '/account/verification/phone';

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Token.fromMap(res.data);

    }

    /// Create Phone Verification (confirmation)
    ///
    /// Use this endpoint to complete the user phone verification process. Use the
    /// **userId** and **secret** that were sent to your user's phone number to
    /// verify the user email ownership. If confirmed this route will return a 200
    /// status code.
    ///
    Future<models.Token> updatePhoneVerification({required String userId, required String secret}) async {
        const String path = '/account/verification/phone';

        final Map<String, dynamic> params = {
            'userId': userId,
            'secret': secret,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: path, params: params, headers: headers);

        return models.Token.fromMap(res.data);

    }
}
