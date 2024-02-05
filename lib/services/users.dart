part of appwrite;

/// The Users service allows you to manage your project users.
class Users extends Service {
    /// Initializes a [Users] service
    Users(super.client);

    /// Delete Authenticator
    ///
    Future<models.User> deleteAuthenticator({required String userId, required enums.AuthenticatorProvider provider, required String otp}) async {
        final String apiPath = '/users/{userId}/mfa/{provider}'.replaceAll('{userId}', userId).replaceAll('{provider}', provider);

        final Map<String, dynamic> apiParams = {
            'otp': otp,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.User.fromMap(res.data);

    }

    /// List Providers
    ///
    Future<models.MfaProviders> listProviders({required String userId}) async {
        final String apiPath = '/users/{userId}/providers'.replaceAll('{userId}', userId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.MfaProviders.fromMap(res.data);

    }
}