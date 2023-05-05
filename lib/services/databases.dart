part of appwrite;

/// The Databases service allows you to create structured collections of
/// documents, query and filter lists of documents
class Databases extends Service {
  Databases(super.client);

  /// List Documents
  ///
  /// Get a list of all the user's documents in a given collection. You can use
  /// the query params to filter your results.
  ///
  Future<models.DocumentList> listDocuments(
      {required String databaseId,
      required String collectionId,
      List<String>? queries}) async {
    final String path =
        '/databases/{databaseId}/collections/{collectionId}/documents'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId);

    final Map<String, dynamic> params = {
      'queries': queries,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.get,
      path,
      params: params,
      headers: headers,
    ));

    return models.DocumentList.fromMap(res.data);
  }

  /// Create Document
  ///
  /// Create a new Document. Before using this route, you should create a new
  /// collection resource using either a [server
  /// integration](/docs/server/databases#databasesCreateCollection) API or
  /// directly from your database console.
  ///
  Future<models.Document> createDocument(
      {required String databaseId,
      required String collectionId,
      required String documentId,
      required Map data,
      List<String>? permissions}) async {
    final String path =
        '/databases/{databaseId}/collections/{collectionId}/documents'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId);

    final Map<String, dynamic> params = {
      'documentId': documentId,
      'data': data,
      'permissions': permissions,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.post,
      path,
      params: params,
      headers: headers,
    ));

    return models.Document.fromMap(res.data);
  }

  /// Get Document
  ///
  /// Get a document by its unique ID. This endpoint response returns a JSON
  /// object with the document data.
  ///
  Future<models.Document> getDocument(
      {required String databaseId,
      required String collectionId,
      required String documentId}) async {
    final String path =
        '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId)
            .replaceAll('{documentId}', documentId);

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.get,
      path,
      params: params,
      headers: headers,
    ));

    return models.Document.fromMap(res.data);
  }

  /// Update Document
  ///
  /// Update a document by its unique ID. Using the patch method you can pass
  /// only specific fields that will get updated.
  ///
  Future<models.Document> updateDocument(
      {required String databaseId,
      required String collectionId,
      required String documentId,
      Map? data,
      List<String>? permissions}) async {
    final String path =
        '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId)
            .replaceAll('{documentId}', documentId);

    final Map<String, dynamic> params = {
      'data': data,
      'permissions': permissions,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.patch,
      path,
      params: params,
      headers: headers,
    ));

    return models.Document.fromMap(res.data);
  }

  /// Delete Document
  ///
  /// Delete a document by its unique ID.
  ///
  Future deleteDocument(
      {required String databaseId,
      required String collectionId,
      required String documentId}) async {
    final String path =
        '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}'
            .replaceAll('{databaseId}', databaseId)
            .replaceAll('{collectionId}', collectionId)
            .replaceAll('{documentId}', documentId);

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.delete,
      path,
      params: params,
      headers: headers,
    ));

    return res.data;
  }
}
