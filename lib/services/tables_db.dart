part of '../appwrite.dart';

class TablesDB extends Service {
  /// Initializes a [TablesDB] service
  TablesDB(super.client);

  /// Get a list of all the user's rows in a given table. You can use the query
  /// params to filter your results.
  Future<models.RowList> listRows(
      {required String databaseId,
      required String tableId,
      List<String>? queries}) async {
    final String apiPath = '/tablesdb/{databaseId}/tables/{tableId}/rows'
        .replaceAll('{databaseId}', databaseId)
        .replaceAll('{tableId}', tableId);

    final Map<String, dynamic> apiParams = {
      'queries': queries,
    };

    final Map<String, String> apiHeaders = {};

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.RowList.fromMap(res.data);
  }

  /// Create a new Row. Before using this route, you should create a new table
  /// resource using either a [server
  /// integration](https://appwrite.io/docs/server/tablesdb#tablesDBCreateTable)
  /// API or directly from your database console.
  Future<models.Row> createRow(
      {required String databaseId,
      required String tableId,
      required String rowId,
      required Map data,
      List<String>? permissions}) async {
    final String apiPath = '/tablesdb/{databaseId}/tables/{tableId}/rows'
        .replaceAll('{databaseId}', databaseId)
        .replaceAll('{tableId}', tableId);

    final Map<String, dynamic> apiParams = {
      'rowId': rowId,
      'data': data,
      'permissions': permissions,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.post,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Row.fromMap(res.data);
  }

  /// Get a row by its unique ID. This endpoint response returns a JSON object
  /// with the row data.
  Future<models.Row> getRow(
      {required String databaseId,
      required String tableId,
      required String rowId,
      List<String>? queries}) async {
    final String apiPath =
        '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{tableId}', tableId)
            .replaceAll('{rowId}', rowId);

    final Map<String, dynamic> apiParams = {
      'queries': queries,
    };

    final Map<String, String> apiHeaders = {};

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Row.fromMap(res.data);
  }

  /// Create or update a Row. Before using this route, you should create a new
  /// table resource using either a [server
  /// integration](https://appwrite.io/docs/server/tablesdb#tablesDBCreateTable)
  /// API or directly from your database console.
  Future<models.Row> upsertRow(
      {required String databaseId,
      required String tableId,
      required String rowId,
      Map? data,
      List<String>? permissions}) async {
    final String apiPath =
        '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{tableId}', tableId)
            .replaceAll('{rowId}', rowId);

    final Map<String, dynamic> apiParams = {
      'data': data,
      'permissions': permissions,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.put,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Row.fromMap(res.data);
  }

  /// Update a row by its unique ID. Using the patch method you can pass only
  /// specific fields that will get updated.
  Future<models.Row> updateRow(
      {required String databaseId,
      required String tableId,
      required String rowId,
      Map? data,
      List<String>? permissions}) async {
    final String apiPath =
        '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{tableId}', tableId)
            .replaceAll('{rowId}', rowId);

    final Map<String, dynamic> apiParams = {
      'data': data,
      'permissions': permissions,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.patch,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Row.fromMap(res.data);
  }

  /// Delete a row by its unique ID.
  Future deleteRow(
      {required String databaseId,
      required String tableId,
      required String rowId}) async {
    final String apiPath =
        '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{tableId}', tableId)
            .replaceAll('{rowId}', rowId);

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.delete,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return res.data;
  }

  /// Decrement a specific column of a row by a given value.
  Future<models.Row> decrementRowColumn(
      {required String databaseId,
      required String tableId,
      required String rowId,
      required String column,
      double? value,
      double? min}) async {
    final String apiPath =
        '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}/{column}/decrement'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{tableId}', tableId)
            .replaceAll('{rowId}', rowId)
            .replaceAll('{column}', column);

    final Map<String, dynamic> apiParams = {
      'value': value,
      'min': min,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.patch,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Row.fromMap(res.data);
  }

  /// Increment a specific column of a row by a given value.
  Future<models.Row> incrementRowColumn(
      {required String databaseId,
      required String tableId,
      required String rowId,
      required String column,
      double? value,
      double? max}) async {
    final String apiPath =
        '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}/{column}/increment'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{tableId}', tableId)
            .replaceAll('{rowId}', rowId)
            .replaceAll('{column}', column);

    final Map<String, dynamic> apiParams = {
      'value': value,
      'max': max,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.patch,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Row.fromMap(res.data);
  }
}
