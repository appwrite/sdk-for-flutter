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
    Future<Response> listExecutions({required String functionId
, String? search
, int? limit
, int? offset
, String? orderType
}) {
        final String path = '/functions/{functionId}/executions'.replaceAll(RegExp('{functionId}'), functionId);

        final Map<String, dynamic> params = {
            'search': search,
            'limit': limit,
            'offset': offset,
            'orderType': orderType?.name(),
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        return client.call(HttpMethod.get, path: path, params: params, headers: headers);
    }

     /// Create Execution
     ///
     /// Trigger a function execution. The returned object will return you the
     /// current execution status. You can ping the `Get Execution` endpoint to get
     /// updates on the current execution status. Once this endpoint is called, your
     /// function execution process will start asynchronously.
     ///
    Future<Response> createExecution({required String functionId
, String? data
}) {
        final String path = '/functions/{functionId}/executions'.replaceAll(RegExp('{functionId}'), functionId);

        final Map<String, dynamic> params = {
            'data': data,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        return client.call(HttpMethod.post, path: path, params: params, headers: headers);
    }

     /// Get Execution
     ///
     /// Get a function execution log by its unique ID.
     ///
    Future<Response> getExecution({required String functionId
, required String executionId
}) {
        final String path = '/functions/{functionId}/executions/{executionId}'.replaceAll(RegExp('{functionId}'), functionId).replaceAll(RegExp('{executionId}'), executionId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        return client.call(HttpMethod.get, path: path, params: params, headers: headers);
    }
}