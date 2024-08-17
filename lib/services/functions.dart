part of '../appwrite.dart';

/// The Functions Service allows you view, create and manage your Cloud
/// Functions.
class Functions extends Service {
  /// Initializes a [Functions] service
  Functions(super.client);

  /// List function templates
  ///
  /// List available function templates. You can use template details in
  /// [createFunction](/docs/references/cloud/server-nodejs/functions#create)
  /// method.
  Future<models.TemplateFunctionList> listTemplates(
      {List<String>? runtimes,
      List<String>? useCases,
      int? limit,
      int? offset}) async {
    const String apiPath = '/functions/templates';

    final Map<String, dynamic> apiParams = {
      'runtimes': runtimes,
      'useCases': useCases,
      'limit': limit,
      'offset': offset,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.TemplateFunctionList.fromMap(res.data);
  }

  /// Get function template
  ///
  /// Get a function template using ID. You can use template details in
  /// [createFunction](/docs/references/cloud/server-nodejs/functions#create)
  /// method.
  Future<models.TemplateFunction> getTemplate(
      {required String templateId}) async {
    final String apiPath = '/functions/templates/{templateId}'
        .replaceAll('{templateId}', templateId);

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.TemplateFunction.fromMap(res.data);
  }

  /// Download deployment
  ///
  /// Get a Deployment's contents by its unique ID. This endpoint supports range
  /// requests for partial or streaming file download.
  Future<Uint8List> getDeploymentDownload(
      {required String functionId, required String deploymentId}) async {
    final String apiPath =
        '/functions/{functionId}/deployments/{deploymentId}/download'
            .replaceAll('{functionId}', functionId)
            .replaceAll('{deploymentId}', deploymentId);

    final Map<String, dynamic> params = {
      'project': client.config['project'],
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: params, responseType: ResponseType.bytes);
    return res.data;
  }

  /// List executions
  ///
  /// Get a list of all the current user function execution logs. You can use the
  /// query params to filter your results.
  Future<models.ExecutionList> listExecutions(
      {required String functionId,
      List<String>? queries,
      String? search}) async {
    final String apiPath = '/functions/{functionId}/executions'
        .replaceAll('{functionId}', functionId);

    final Map<String, dynamic> apiParams = {
      'queries': queries,
      'search': search,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.ExecutionList.fromMap(res.data);
  }

  /// Create execution
  ///
  /// Trigger a function execution. The returned object will return you the
  /// current execution status. You can ping the `Get Execution` endpoint to get
  /// updates on the current execution status. Once this endpoint is called, your
  /// function execution process will start asynchronously.
  Future<models.Execution> createExecution(
      {required String functionId,
      String? body,
      bool? xasync,
      String? path,
      enums.ExecutionMethod? method,
      Map? headers,
      String? scheduledAt,
      Function(UploadProgress)? onProgress}) async {
    final String apiPath = '/functions/{functionId}/executions'
        .replaceAll('{functionId}', functionId);

    final Map<String, dynamic> apiParams = {
      'body': body,
      'async': xasync,
      'path': path,
      'method': method?.value,
      'headers': headers,
      'scheduledAt': scheduledAt,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'multipart/form-data',
    };

    String idParamName = '';
    final res = await client.chunkedUpload(
      path: apiPath,
      params: apiParams,
      paramName: paramName,
      idParamName: idParamName,
      headers: apiHeaders,
      onProgress: onProgress,
    );

    return models.Execution.fromMap(res.data);
  }

  /// Get execution
  ///
  /// Get a function execution log by its unique ID.
  Future<models.Execution> getExecution(
      {required String functionId, required String executionId}) async {
    final String apiPath = '/functions/{functionId}/executions/{executionId}'
        .replaceAll('{functionId}', functionId)
        .replaceAll('{executionId}', executionId);

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Execution.fromMap(res.data);
  }
}
