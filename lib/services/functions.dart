part of appwrite;

class Functions extends Service {
    Functions(Client client): super(client);

     /// List Executions
     ///
     /// Get a list of all the current user function execution logs. You can use the
     /// query params to filter your results. On admin mode, this endpoint will
     /// return a list of all of the project's executions. [Learn more about
     /// different API modes](/docs/admin).
     ///
     Future<models.ExecutionList> listExecutions({required String functionId, String? search, int? limit, int? offset, String? orderType}) async {
        final String path = '/functions/{functionId}/executions'.replaceAll(RegExp('{functionId}'), functionId);

        final Map<String, dynamic> params = {
            'search': search,
            'limit': limit,
            'offset': offset,
            'orderType': orderType,
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
     Future<models.Execution> createExecution({required String functionId, String? data}) async {
        final String path = '/functions/{functionId}/executions'.replaceAll(RegExp('{functionId}'), functionId);

        final Map<String, dynamic> params = {
            'data': data,
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
        final String path = '/functions/{functionId}/executions/{executionId}'.replaceAll(RegExp('{functionId}'), functionId).replaceAll(RegExp('{executionId}'), executionId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);
        return models.Execution.fromMap(res.data);
    }
}