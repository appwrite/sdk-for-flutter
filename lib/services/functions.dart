part of '../appwrite.dart';

/// The Functions Service allows you view, create and manage your Cloud
/// Functions.
class Functions extends Service {
  /// Initializes a [Functions] service
  Functions(super.client);

  /// Get a list of all the current user function execution logs. You can use the
  /// query params to filter your results.
  Future<models.ExecutionList> listExecutions({
    required String functionId,
    List<String>? queries,
  }) async {
    final String apiPath = '/functions/{functionId}/executions'.replaceAll(
      '{functionId}',
      functionId,
    );

    final Map<String, dynamic> apiParams = {'queries': queries};

    final Map<String, String> apiHeaders = {};

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.ExecutionList.fromMap(res.data);
  }

  /// Trigger a function execution. The returned object will return you the
  /// current execution status. You can ping the `Get Execution` endpoint to get
  /// updates on the current execution status. Once this endpoint is called, your
  /// function execution process will start asynchronously.
  Future<models.Execution> createExecution({
    required String functionId,
    String? body,
    bool? xasync,
    String? path,
    enums.ExecutionMethod? method,
    Map? headers,
    String? scheduledAt,
  }) async {
    final String apiPath = '/functions/{functionId}/executions'.replaceAll(
      '{functionId}',
      functionId,
    );

    final Map<String, dynamic> apiParams = {
      'body': body,
      'async': xasync,
      'path': path,
      'method': method?.value,
      'headers': headers,
      'scheduledAt': scheduledAt,
    };

    final Map<String, String> apiHeaders = {'content-type': 'application/json'};

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Execution.fromMap(res.data);
  }

  /// Get a function execution log by its unique ID.
  Future<models.Execution> getExecution({
    required String functionId,
    required String executionId,
  }) async {
    final String apiPath = '/functions/{functionId}/executions/{executionId}'
        .replaceAll('{functionId}', functionId)
        .replaceAll('{executionId}', executionId);

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {};

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Execution.fromMap(res.data);
  }
}
