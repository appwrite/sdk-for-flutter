part of '../appwrite.dart';

class VectorsDB extends Service {
  /// Initializes a [VectorsDB] service
  VectorsDB(super.client);

  /// List transactions across all databases.
  Future<models.TransactionList> listTransactions({
    List<String>? queries,
  }) async {
    final String apiPath = '/vectorsdb/transactions';

    final Map<String, dynamic> apiParams = {
      if (queries != null) 'queries': queries,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.TransactionList.fromMap(res.data);
  }

  /// Create a new transaction.
  Future<models.Transaction> createTransaction({
    int? ttl,
  }) async {
    final String apiPath = '/vectorsdb/transactions';

    final Map<String, dynamic> apiParams = {
      if (ttl != null) 'ttl': ttl,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Transaction.fromMap(res.data);
  }

  /// Get a transaction by its unique ID.
  Future<models.Transaction> getTransaction({
    required String transactionId,
  }) async {
    final String apiPath = '/vectorsdb/transactions/{transactionId}'.replaceAll(
      '{transactionId}',
      transactionId,
    );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Transaction.fromMap(res.data);
  }

  /// Update a transaction, to either commit or roll back its operations.
  Future<models.Transaction> updateTransaction({
    required String transactionId,
    bool? commit,
    bool? rollback,
  }) async {
    final String apiPath = '/vectorsdb/transactions/{transactionId}'.replaceAll(
      '{transactionId}',
      transactionId,
    );

    final Map<String, dynamic> apiParams = {
      if (commit != null) 'commit': commit,
      if (rollback != null) 'rollback': rollback,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.patch,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Transaction.fromMap(res.data);
  }

  /// Delete a transaction by its unique ID.
  Future deleteTransaction({
    required String transactionId,
  }) async {
    final String apiPath = '/vectorsdb/transactions/{transactionId}'.replaceAll(
      '{transactionId}',
      transactionId,
    );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
    };

    final res = await client.call(
      HttpMethod.delete,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }

  /// Create multiple operations in a single transaction.
  Future<models.Transaction> createOperations({
    required String transactionId,
    List<Map>? operations,
  }) async {
    final String apiPath =
        '/vectorsdb/transactions/{transactionId}/operations'.replaceAll(
      '{transactionId}',
      transactionId,
    );

    final Map<String, dynamic> apiParams = {
      if (operations != null) 'operations': operations,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Transaction.fromMap(res.data);
  }

  /// Get a list of all the user's documents in a given collection. You can use
  /// the query params to filter your results.
  Future<models.DocumentList> listDocuments({
    required String databaseId,
    required String collectionId,
    List<String>? queries,
    String? transactionId,
    bool? total,
    int? ttl,
  }) async {
    final String apiPath =
        '/vectorsdb/{databaseId}/collections/{collectionId}/documents'
            .replaceAll(
              '{databaseId}',
              databaseId,
            )
            .replaceAll(
              '{collectionId}',
              collectionId,
            );

    final Map<String, dynamic> apiParams = {
      if (queries != null) 'queries': queries,
      if (transactionId != null) 'transactionId': transactionId,
      if (total != null) 'total': total,
      if (ttl != null) 'ttl': ttl,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.DocumentList.fromMap(res.data);
  }

  /// Create a new Document. Before using this route, you should create a new
  /// collection resource using either a [server
  /// integration](https://appwrite.io/docs/server/databases#documentsDBCreateCollection)
  /// API or directly from your database console.
  Future<models.Document> createDocument({
    required String databaseId,
    required String collectionId,
    required String documentId,
    required Map data,
    List<String>? permissions,
    String? transactionId,
  }) async {
    final String apiPath =
        '/vectorsdb/{databaseId}/collections/{collectionId}/documents'
            .replaceAll(
              '{databaseId}',
              databaseId,
            )
            .replaceAll(
              '{collectionId}',
              collectionId,
            );

    final Map<String, dynamic> apiParams = {
      'documentId': documentId,
      'data': data,
      if (permissions != null) 'permissions': permissions,
      if (transactionId != null) 'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Document.fromMap(res.data);
  }

  /// Get a list of all the user's documents in a given collection using a POST
  /// request. This behaves identically to the list documents endpoint but
  /// accepts the queries in the request body, allowing much larger `queries`
  /// arrays than can fit in a URL query string.
  Future<models.DocumentList> createQuery({
    required String databaseId,
    required String collectionId,
    List<String>? queries,
    String? transactionId,
    bool? total,
    int? ttl,
  }) async {
    final String apiPath =
        '/vectorsdb/{databaseId}/collections/{collectionId}/documents/query'
            .replaceAll(
              '{databaseId}',
              databaseId,
            )
            .replaceAll(
              '{collectionId}',
              collectionId,
            );

    final Map<String, dynamic> apiParams = {
      if (queries != null) 'queries': queries,
      if (transactionId != null) 'transactionId': transactionId,
      if (total != null) 'total': total,
      if (ttl != null) 'ttl': ttl,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.DocumentList.fromMap(res.data);
  }

  /// Get a document by its unique ID. This endpoint response returns a JSON
  /// object with the document data.
  Future<models.Document> getDocument({
    required String databaseId,
    required String collectionId,
    required String documentId,
    List<String>? queries,
    String? transactionId,
  }) async {
    final String apiPath =
        '/vectorsdb/{databaseId}/collections/{collectionId}/documents/{documentId}'
            .replaceAll(
              '{databaseId}',
              databaseId,
            )
            .replaceAll(
              '{collectionId}',
              collectionId,
            )
            .replaceAll(
              '{documentId}',
              documentId,
            );

    final Map<String, dynamic> apiParams = {
      if (queries != null) 'queries': queries,
      if (transactionId != null) 'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Document.fromMap(res.data);
  }

  /// Create or update a Document. Before using this route, you should create a
  /// new collection resource using either a [server
  /// integration](https://appwrite.io/docs/server/databases#documentsDBCreateCollection)
  /// API or directly from your database console.
  Future<models.Document> upsertDocument({
    required String databaseId,
    required String collectionId,
    required String documentId,
    Map? data,
    List<String>? permissions,
    String? transactionId,
  }) async {
    final String apiPath =
        '/vectorsdb/{databaseId}/collections/{collectionId}/documents/{documentId}'
            .replaceAll(
              '{databaseId}',
              databaseId,
            )
            .replaceAll(
              '{collectionId}',
              collectionId,
            )
            .replaceAll(
              '{documentId}',
              documentId,
            );

    final Map<String, dynamic> apiParams = {
      if (data != null) 'data': data,
      if (permissions != null) 'permissions': permissions,
      if (transactionId != null) 'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.put,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Document.fromMap(res.data);
  }

  /// Update a document by its unique ID. Using the patch method you can pass
  /// only specific fields that will get updated.
  Future<models.Document> updateDocument({
    required String databaseId,
    required String collectionId,
    required String documentId,
    Map? data,
    List<String>? permissions,
    String? transactionId,
  }) async {
    final String apiPath =
        '/vectorsdb/{databaseId}/collections/{collectionId}/documents/{documentId}'
            .replaceAll(
              '{databaseId}',
              databaseId,
            )
            .replaceAll(
              '{collectionId}',
              collectionId,
            )
            .replaceAll(
              '{documentId}',
              documentId,
            );

    final Map<String, dynamic> apiParams = {
      if (data != null) 'data': data,
      if (permissions != null) 'permissions': permissions,
      if (transactionId != null) 'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.patch,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Document.fromMap(res.data);
  }

  /// Delete a document by its unique ID.
  Future deleteDocument({
    required String databaseId,
    required String collectionId,
    required String documentId,
    String? transactionId,
  }) async {
    final String apiPath =
        '/vectorsdb/{databaseId}/collections/{collectionId}/documents/{documentId}'
            .replaceAll(
              '{databaseId}',
              databaseId,
            )
            .replaceAll(
              '{collectionId}',
              collectionId,
            )
            .replaceAll(
              '{documentId}',
              documentId,
            );

    final Map<String, dynamic> apiParams = {
      if (transactionId != null) 'transactionId': transactionId,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
    };

    final res = await client.call(
      HttpMethod.delete,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }
}
