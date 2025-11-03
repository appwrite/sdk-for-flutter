part of '../appwrite.dart';

class TablesDB extends Service {
  /// Initializes a [TablesDB] service
  TablesDB(super.client);

  /// List transactions across all databases.
  Future<models.TransactionList> listTransactions({List<String>? queries}) async {
    const String apiPath = '/tablesdb/transactions';

        final Map<String, dynamic> apiParams = {
            'queries': queries,
        };

        final Map<String, String> apiHeaders = {

        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.TransactionList.fromMap(res.data);

  }

  /// Create a new transaction.
  Future<models.Transaction> createTransaction({int? ttl}) async {
    const String apiPath = '/tablesdb/transactions';

        final Map<String, dynamic> apiParams = {
            'ttl': ttl,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Transaction.fromMap(res.data);

  }

  /// Get a transaction by its unique ID.
  Future<models.Transaction> getTransaction({required String transactionId}) async {
    final String apiPath = '/tablesdb/transactions/{transactionId}'.replaceAll('{transactionId}', transactionId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {

        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Transaction.fromMap(res.data);

  }

  /// Update a transaction, to either commit or roll back its operations.
  Future<models.Transaction> updateTransaction({required String transactionId, bool? commit, bool? rollback}) async {
    final String apiPath = '/tablesdb/transactions/{transactionId}'.replaceAll('{transactionId}', transactionId);

        final Map<String, dynamic> apiParams = {
            'commit': commit,
            'rollback': rollback,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Transaction.fromMap(res.data);

  }

  /// Delete a transaction by its unique ID.
  Future deleteTransaction({required String transactionId}) async {
    final String apiPath = '/tablesdb/transactions/{transactionId}'.replaceAll('{transactionId}', transactionId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

  }

  /// Create multiple operations in a single transaction.
  Future<models.Transaction> createOperations({required String transactionId, List<Map>? operations}) async {
    final String apiPath = '/tablesdb/transactions/{transactionId}/operations'.replaceAll('{transactionId}', transactionId);

        final Map<String, dynamic> apiParams = {
            'operations': operations,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Transaction.fromMap(res.data);

  }

  /// Get a list of all the user's rows in a given table. You can use the query
  /// params to filter your results.
  Future<models.RowList> listRows({required String databaseId, required String tableId, List<String>? queries, String? transactionId, bool? total}) async {
    final String apiPath = '/tablesdb/{databaseId}/tables/{tableId}/rows'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId);

        final Map<String, dynamic> apiParams = {
            'queries': queries,
            'transactionId': transactionId,
            'total': total,
        };

        final Map<String, String> apiHeaders = {

        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.RowList.fromMap(res.data);

  }

  /// Create a new Row. Before using this route, you should create a new table
  /// resource using either a [server
  /// integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable)
  /// API or directly from your database console.
  Future<models.Row> createRow({required String databaseId, required String tableId, required String rowId, required Map data, List<String>? permissions, String? transactionId}) async {
    final String apiPath = '/tablesdb/{databaseId}/tables/{tableId}/rows'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId);

        final Map<String, dynamic> apiParams = {
            'rowId': rowId,
            'data': data,
            'permissions': permissions,
            'transactionId': transactionId,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Row.fromMap(res.data);

  }

  /// Get a row by its unique ID. This endpoint response returns a JSON object
  /// with the row data.
  Future<models.Row> getRow({required String databaseId, required String tableId, required String rowId, List<String>? queries, String? transactionId}) async {
    final String apiPath = '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId).replaceAll('{rowId}', rowId);

        final Map<String, dynamic> apiParams = {
            'queries': queries,
            'transactionId': transactionId,
        };

        final Map<String, String> apiHeaders = {

        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Row.fromMap(res.data);

  }

  /// Create or update a Row. Before using this route, you should create a new
  /// table resource using either a [server
  /// integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable)
  /// API or directly from your database console.
  Future<models.Row> upsertRow({required String databaseId, required String tableId, required String rowId, Map? data, List<String>? permissions, String? transactionId}) async {
    final String apiPath = '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId).replaceAll('{rowId}', rowId);

        final Map<String, dynamic> apiParams = {
            'data': data,
            'permissions': permissions,
            'transactionId': transactionId,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Row.fromMap(res.data);

  }

  /// Update a row by its unique ID. Using the patch method you can pass only
  /// specific fields that will get updated.
  Future<models.Row> updateRow({required String databaseId, required String tableId, required String rowId, Map? data, List<String>? permissions, String? transactionId}) async {
    final String apiPath = '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId).replaceAll('{rowId}', rowId);

        final Map<String, dynamic> apiParams = {
            'data': data,
            'permissions': permissions,
            'transactionId': transactionId,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Row.fromMap(res.data);

  }

  /// Delete a row by its unique ID.
  Future deleteRow({required String databaseId, required String tableId, required String rowId, String? transactionId}) async {
    final String apiPath = '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId).replaceAll('{rowId}', rowId);

        final Map<String, dynamic> apiParams = {
            'transactionId': transactionId,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

  }

  /// Decrement a specific column of a row by a given value.
  Future<models.Row> decrementRowColumn({required String databaseId, required String tableId, required String rowId, required String column, double? value, double? min, String? transactionId}) async {
    final String apiPath = '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}/{column}/decrement'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId).replaceAll('{rowId}', rowId).replaceAll('{column}', column);

        final Map<String, dynamic> apiParams = {
            'value': value,
            'min': min,
            'transactionId': transactionId,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Row.fromMap(res.data);

  }

  /// Increment a specific column of a row by a given value.
  Future<models.Row> incrementRowColumn({required String databaseId, required String tableId, required String rowId, required String column, double? value, double? max, String? transactionId}) async {
    final String apiPath = '/tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}/{column}/increment'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId).replaceAll('{rowId}', rowId).replaceAll('{column}', column);

        final Map<String, dynamic> apiParams = {
            'value': value,
            'max': max,
            'transactionId': transactionId,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Row.fromMap(res.data);

  }
}