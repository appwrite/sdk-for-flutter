part of appwrite;

    /// The Functions Service allows you view, create and manage your Cloud
    /// Functions.
class Functions extends Service {
    Functions(Client client): super(client);

    /// Retry Build
    Future retryBuild({required String functionId, required String deploymentId, required String buildId}) async {
        final String path = '/functions/{functionId}/deployments/{deploymentId}/builds/{buildId}'.replaceAll('{functionId}', functionId).replaceAll('{deploymentId}', deploymentId).replaceAll('{buildId}', buildId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return  res.data;

    }

    /// List Executions
    ///
    /// Get a list of all the current user function execution logs. You can use the
    /// query params to filter your results. On admin mode, this endpoint will
    /// return a list of all of the project's executions. [Learn more about
    /// different API modes](/docs/admin).
    ///
    Future<models.ExecutionList> listExecutions({required String functionId, int? limit, int? offset, String? search, String? cursor, String? cursorDirection}) async {
        final String path = '/functions/{functionId}/executions'.replaceAll('{functionId}', functionId);

        final Map<String, dynamic> params = {
            'limit': limit,
            'offset': offset,
            'search': search,
            'cursor': cursor,
            'cursorDirection': cursorDirection,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.ExecutionList.fromMap(res.data);

    }

    /// Create Execution
    ///
    /// Trigger a function execution. The returned object will return you the
    /// current execution status. You can ping the `Get Execution` endpoint to get
    /// updates on the current execution status. Once this endpoint is called, your
    /// function execution process will start asynchronously.
    ///
    Future<models.Execution> createExecution({required String functionId, String? data, bool? xasync}) async {
        final String path = '/functions/{functionId}/executions'.replaceAll('{functionId}', functionId);

        final Map<String, dynamic> params = {
            'data': data,
            'async': xasync,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Execution.fromMap(res.data);

    }

    /// Get Execution
    ///
    /// Get a function execution log by its unique ID.
    ///
    Future<models.Execution> getExecution({required String functionId, required String executionId}) async {
        final String path = '/functions/{functionId}/executions/{executionId}'.replaceAll('{functionId}', functionId).replaceAll('{executionId}', executionId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.Execution.fromMap(res.data);

    }
}