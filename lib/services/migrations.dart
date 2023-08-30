part of appwrite;

/// The Migrations service allows you to migrate third-party data to your
/// Appwrite project.
class Migrations extends Service {
    /// Initializes a [Migrations] service
    Migrations(super.client);

    /// Revoke Appwrite&#039;s authorization to access Firebase Projects
    ///
    Future deleteFirebaseAuth() async {
        const String apiPath = '/migrations/firebase/deauthorize';

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: params, headers: headers);

        return  res.data;

    }

    /// List Firebase Projects
    ///
    Future<models.FirebaseProjectList> listFirebaseProjects() async {
        const String apiPath = '/migrations/firebase/projects';

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: params, headers: headers);

        return models.FirebaseProjectList.fromMap(res.data);

    }
}