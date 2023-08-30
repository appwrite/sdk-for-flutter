part of appwrite;

class Vcs extends Service {
    /// Initializes a [Vcs] service
    Vcs(super.client);

    /// List Repositories
    ///
    Future<models.ProviderRepositoryList> listRepositories({required String installationId, String? search}) async {
        final String apiPath = '/vcs/github/installations/{installationId}/providerRepositories'.replaceAll('{installationId}', installationId);

        final Map<String, dynamic> params = {
            'search': search,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: params, headers: headers);

        return models.ProviderRepositoryList.fromMap(res.data);

    }

    /// Create repository
    ///
    Future<models.ProviderRepository> createRepository({required String installationId, required String name, required bool private}) async {
        final String apiPath = '/vcs/github/installations/{installationId}/providerRepositories'.replaceAll('{installationId}', installationId);

        final Map<String, dynamic> params = {
            'name': name,
            'private': private,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: params, headers: headers);

        return models.ProviderRepository.fromMap(res.data);

    }

    /// Get repository
    ///
    Future<models.ProviderRepository> getRepository({required String installationId, required String providerRepositoryId}) async {
        final String apiPath = '/vcs/github/installations/{installationId}/providerRepositories/{providerRepositoryId}'.replaceAll('{installationId}', installationId).replaceAll('{providerRepositoryId}', providerRepositoryId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: params, headers: headers);

        return models.ProviderRepository.fromMap(res.data);

    }

    /// List Repository Branches
    ///
    Future<models.BranchList> listRepositoryBranches({required String installationId, required String providerRepositoryId}) async {
        final String apiPath = '/vcs/github/installations/{installationId}/providerRepositories/{providerRepositoryId}/branches'.replaceAll('{installationId}', installationId).replaceAll('{providerRepositoryId}', providerRepositoryId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: params, headers: headers);

        return models.BranchList.fromMap(res.data);

    }

    /// Detect runtime settings from source code
    ///
    Future<models.Detection> createRepositoryDetection({required String installationId, required String providerRepositoryId, String? providerRootDirectory}) async {
        final String apiPath = '/vcs/github/installations/{installationId}/providerRepositories/{providerRepositoryId}/detection'.replaceAll('{installationId}', installationId).replaceAll('{providerRepositoryId}', providerRepositoryId);

        final Map<String, dynamic> params = {
            'providerRootDirectory': providerRootDirectory,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: params, headers: headers);

        return models.Detection.fromMap(res.data);

    }

    /// Authorize external deployment
    ///
    Future updateExternalDeployments({required String installationId, required String repositoryId, required String providerPullRequestId}) async {
        final String apiPath = '/vcs/github/installations/{installationId}/repositories/{repositoryId}'.replaceAll('{installationId}', installationId).replaceAll('{repositoryId}', repositoryId);

        final Map<String, dynamic> params = {
            'providerPullRequestId': providerPullRequestId,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: params, headers: headers);

        return  res.data;

    }
}