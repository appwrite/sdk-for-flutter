part of '../appwrite.dart';

/// The Tables service allows you to create structured tables of rows, query
/// and filter lists of rows
class Tables extends Service {
    /// Initializes a [Tables] service
    Tables(super.client);

    /// Get a list of all the user's rows in a given table. You can use the query
    /// params to filter your results.
    Future<models.RowList> listRows({required String databaseId, required String tableId, List<String>? queries}) async {
        final String apiPath = '/databases/{databaseId}/tables/{tableId}/rows'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId);

        final Map<String, dynamic> apiParams = {
            'queries': queries,
        };

        final Map<String, String> apiHeaders = {

        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.RowList.fromMap(res.data);

    }

    /// Create a new Row. Before using this route, you should create a new table
    /// resource using either a [server
    /// integration](https://appwrite.io/docs/server/databases#databasesCreateTable)
    /// API or directly from your database console.
    Future<models.Row> createRow({required String databaseId, required String tableId, required String rowId, required Map data, List<String>? permissions}) async {
        final String apiPath = '/databases/{databaseId}/tables/{tableId}/rows'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId);

        final Map<String, dynamic> apiParams = {
            'rowId': rowId,
            'data': data,
            'permissions': permissions,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Row.fromMap(res.data);

    }

    /// Create new Rows. Before using this route, you should create a new table
    /// resource using either a [server
    /// integration](https://appwrite.io/docs/server/databases#databasesCreateTable)
    /// API or directly from your database console.
    Future<models.RowList> createRows({required String databaseId, required String tableId, required List<Map> rows}) async {
        final String apiPath = '/databases/{databaseId}/tables/{tableId}/rows'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId);

        final Map<String, dynamic> apiParams = {
            'rows': rows,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.RowList.fromMap(res.data);

    }

    /// Get a row by its unique ID. This endpoint response returns a JSON object
    /// with the row data.
    Future<models.Row> getRow({required String databaseId, required String tableId, required String rowId, List<String>? queries}) async {
        final String apiPath = '/databases/{databaseId}/tables/{tableId}/rows/{rowId}'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId).replaceAll('{rowId}', rowId);

        final Map<String, dynamic> apiParams = {
            'queries': queries,
        };

        final Map<String, String> apiHeaders = {

        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Row.fromMap(res.data);

    }

    /// Create or update a Row. Before using this route, you should create a new
    /// table resource using either a [server
    /// integration](https://appwrite.io/docs/server/databases#databasesCreateTable)
    /// API or directly from your database console.
    Future<models.Row> upsertRow({required String databaseId, required String tableId, required String rowId}) async {
        final String apiPath = '/databases/{databaseId}/tables/{tableId}/rows/{rowId}'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId).replaceAll('{rowId}', rowId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Row.fromMap(res.data);

    }

    /// Update a row by its unique ID. Using the patch method you can pass only
    /// specific fields that will get updated.
    Future<models.Row> updateRow({required String databaseId, required String tableId, required String rowId, Map? data, List<String>? permissions}) async {
        final String apiPath = '/databases/{databaseId}/tables/{tableId}/rows/{rowId}'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId).replaceAll('{rowId}', rowId);

        final Map<String, dynamic> apiParams = {
            'data': data,
            'permissions': permissions,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Row.fromMap(res.data);

    }

    /// Delete a row by its unique ID.
    Future deleteRow({required String databaseId, required String tableId, required String rowId}) async {
        final String apiPath = '/databases/{databaseId}/tables/{tableId}/rows/{rowId}'.replaceAll('{databaseId}', databaseId).replaceAll('{tableId}', tableId).replaceAll('{rowId}', rowId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

    }
}