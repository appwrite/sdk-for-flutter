part of '../appwrite.dart';

/// The Databases service allows you to create structured collections of
/// documents, query and filter lists of documents
class Databases extends Service {
  /// Initializes a [Databases] service
  Databases(super.client);

  /// List transactions across all databases.
  Future<models.TransactionList> listTransactions(
      {List<String>? queries}) async {
    const String apiPath = '/databases/transactions';

    final Map<String, dynamic> apiParams = {
      'queries': queries,
    };

    final Map<String, String> apiHeaders = {};

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.TransactionList.fromMap(res.data);
  }

  /// Create a new transaction.
  Future<models.Transaction> createTransaction({int? ttl}) async {
    const String apiPath = '/databases/transactions';

    final Map<String, dynamic> apiParams = {
      'ttl': ttl,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.post,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Transaction.fromMap(res.data);
  }

  /// Get a transaction by its unique ID.
  Future<models.Transaction> getTransaction(
      {required String transactionId}) async {
    final String apiPath = '/databases/transactions/{transactionId}'
        .replaceAll('{transactionId}', transactionId);

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {};

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Transaction.fromMap(res.data);
  }

  /// Update a transaction, to either commit or roll back its operations.
  Future<models.Transaction> updateTransaction(
      {required String transactionId, bool? commit, bool? rollback}) async {
    final String apiPath = '/databases/transactions/{transactionId}'
        .replaceAll('{transactionId}', transactionId);

    final Map<String, dynamic> apiParams = {
      'commit': commit,
      'rollback': rollback,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.patch,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Transaction.fromMap(res.data);
  }

  /// Delete a transaction by its unique ID.
  Future deleteTransaction({required String transactionId}) async {
    final String apiPath = '/databases/transactions/{transactionId}'
        .replaceAll('{transactionId}', transactionId);

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.delete,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return res.data;
  }

  /// Create multiple operations in a single transaction.
  Future<models.Transaction> createOperations(
      {required String transactionId, List<Map>? operations}) async {
    final String apiPath = '/databases/transactions/{transactionId}/operations'
        .replaceAll('{transactionId}', transactionId);

    final Map<String, dynamic> apiParams = {
      'operations': operations,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.post,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Transaction.fromMap(res.data);
  }

  /// Get a list of all the user's documents in a given collection. You can use
  /// the query params to filter your results.
  @Deprecated(
      'This API has been deprecated since 1.8.0. Please use `TablesDB.listRows` instead.')
  Future<models.DocumentList> listDocuments(
      {required String databaseId,
      required String collectionId,
      List<String>? queries,
      String? transactionId,
      bool? total}) async {
    final String apiPath =
        '/databases/{databaseId}/collections/{collectionId}/documents'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId);

    final Map<String, dynamic> apiParams = {
      'queries': queries,
      'transactionId': transactionId,
      'total': total,
    };

    final Map<String, String> apiHeaders = {};

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.DocumentList.fromMap(res.data);
  }

  /// Create a new Document. Before using this route, you should create a new
  /// collection resource using either a [server
  /// integration](https://appwrite.io/docs/server/databases#databasesCreateCollection)
  /// API or directly from your database console.
  @Deprecated(
      'This API has been deprecated since 1.8.0. Please use `TablesDB.createRow` instead.')
  Future<models.Document> createDocument(
      {required String databaseId,
      required String collectionId,
      required String documentId,
      required Map data,
      List<String>? permissions,
      String? transactionId}) async {
    final String apiPath =
        '/databases/{databaseId}/collections/{collectionId}/documents'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId);

    final Map<String, dynamic> apiParams = {
      'documentId': documentId,
      'data': data,
      'permissions': permissions,
      'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.post,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Document.fromMap(res.data);
  }

  /// Get a document by its unique ID. This endpoint response returns a JSON
  /// object with the document data.
  @Deprecated(
      'This API has been deprecated since 1.8.0. Please use `TablesDB.getRow` instead.')
  Future<models.Document> getDocument(
      {required String databaseId,
      required String collectionId,
      required String documentId,
      List<String>? queries,
      String? transactionId}) async {
    final String apiPath =
        '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId)
            .replaceAll('{documentId}', documentId);

    final Map<String, dynamic> apiParams = {
      'queries': queries,
      'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {};

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Document.fromMap(res.data);
  }

  /// Create or update a Document. Before using this route, you should create a
  /// new collection resource using either a [server
  /// integration](https://appwrite.io/docs/server/databases#databasesCreateCollection)
  /// API or directly from your database console.
  @Deprecated(
      'This API has been deprecated since 1.8.0. Please use `TablesDB.upsertRow` instead.')
  Future<models.Document> upsertDocument(
      {required String databaseId,
      required String collectionId,
      required String documentId,
      required Map data,
      List<String>? permissions,
      String? transactionId}) async {
    final String apiPath =
        '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId)
            .replaceAll('{documentId}', documentId);

    final Map<String, dynamic> apiParams = {
      'data': data,
      'permissions': permissions,
      'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.put,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Document.fromMap(res.data);
  }

  /// Update a document by its unique ID. Using the patch method you can pass
  /// only specific fields that will get updated.
  @Deprecated(
      'This API has been deprecated since 1.8.0. Please use `TablesDB.updateRow` instead.')
  Future<models.Document> updateDocument(
      {required String databaseId,
      required String collectionId,
      required String documentId,
      Map? data,
      List<String>? permissions,
      String? transactionId}) async {
    final String apiPath =
        '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId)
            .replaceAll('{documentId}', documentId);

    final Map<String, dynamic> apiParams = {
      'data': data,
      'permissions': permissions,
      'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.patch,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Document.fromMap(res.data);
  }

  /// Delete a document by its unique ID.
  @Deprecated(
      'This API has been deprecated since 1.8.0. Please use `TablesDB.deleteRow` instead.')
  Future deleteDocument(
      {required String databaseId,
      required String collectionId,
      required String documentId,
      String? transactionId}) async {
    final String apiPath =
        '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId)
            .replaceAll('{documentId}', documentId);

    final Map<String, dynamic> apiParams = {
      'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.delete,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return res.data;
  }

  /// Decrement a specific attribute of a document by a given value.
  @Deprecated(
      'This API has been deprecated since 1.8.0. Please use `TablesDB.decrementRowColumn` instead.')
  Future<models.Document> decrementDocumentAttribute(
      {required String databaseId,
      required String collectionId,
      required String documentId,
      required String attribute,
      double? value,
      double? min,
      String? transactionId}) async {
    final String apiPath =
        '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}/{attribute}/decrement'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId)
            .replaceAll('{documentId}', documentId)
            .replaceAll('{attribute}', attribute);

    final Map<String, dynamic> apiParams = {
      'value': value,
      'min': min,
      'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.patch,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Document.fromMap(res.data);
  }

  /// Increment a specific attribute of a document by a given value.
  @Deprecated(
      'This API has been deprecated since 1.8.0. Please use `TablesDB.incrementRowColumn` instead.')
  Future<models.Document> incrementDocumentAttribute(
      {required String databaseId,
      required String collectionId,
      required String documentId,
      required String attribute,
      double? value,
      double? max,
      String? transactionId}) async {
    final String apiPath =
        '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}/{attribute}/increment'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId)
            .replaceAll('{documentId}', documentId)
            .replaceAll('{attribute}', attribute);

    final Map<String, dynamic> apiParams = {
      'value': value,
      'max': max,
      'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.patch,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Document.fromMap(res.data);
  }
}
