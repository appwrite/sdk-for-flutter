part of appwrite;

class Database extends Service {
    Database(Client client): super(client);

     /// List Documents
     ///
     /// Get a list of all the user documents. You can use the query params to
     /// filter your results. On admin mode, this endpoint will return a list of all
     /// of the project's documents. [Learn more about different API
     /// modes](/docs/admin).
     ///
     Future<models.DocumentList> listDocuments({required String collectionId, List? filters, int? limit, int? offset, String? orderField, String? orderType, String? orderCast, String? search}) async {
        final String path = '/database/collections/{collectionId}/documents'.replaceAll(RegExp('{collectionId}'), collectionId);

        final Map<String, dynamic> params = {
            'filters': filters,
            'limit': limit,
            'offset': offset,
            'orderField': orderField,
            'orderType': orderType,
            'orderCast': orderCast,
            'search': search,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);
        return models.DocumentList.fromMap(res.data);
    }

     /// Create Document
     ///
     /// Create a new Document. Before using this route, you should create a new
     /// collection resource using either a [server
     /// integration](/docs/server/database#databaseCreateCollection) API or
     /// directly from your database console.
     ///
     Future<models.Document> createDocument({required String collectionId, required Map data, List? read, List? write, String? parentDocument, String? parentProperty, String? parentPropertyType}) async {
        final String path = '/database/collections/{collectionId}/documents'.replaceAll(RegExp('{collectionId}'), collectionId);

        final Map<String, dynamic> params = {
            'data': data,
            'read': read,
            'write': write,
            'parentDocument': parentDocument,
            'parentProperty': parentProperty,
            'parentPropertyType': parentPropertyType,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);
        return models.Document.fromMap(res.data);
    }

     /// Get Document
     ///
     /// Get a document by its unique ID. This endpoint response returns a JSON
     /// object with the document data.
     ///
     Future<models.Document> getDocument({required String collectionId, required String documentId}) async {
        final String path = '/database/collections/{collectionId}/documents/{documentId}'.replaceAll(RegExp('{collectionId}'), collectionId).replaceAll(RegExp('{documentId}'), documentId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);
        return models.Document.fromMap(res.data);
    }

     /// Update Document
     ///
     /// Update a document by its unique ID. Using the patch method you can pass
     /// only specific fields that will get updated.
     ///
     Future<models.Document> updateDocument({required String collectionId, required String documentId, required Map data, List? read, List? write}) async {
        final String path = '/database/collections/{collectionId}/documents/{documentId}'.replaceAll(RegExp('{collectionId}'), collectionId).replaceAll(RegExp('{documentId}'), documentId);

        final Map<String, dynamic> params = {
            'data': data,
            'read': read,
            'write': write,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: path, params: params, headers: headers);
        return models.Document.fromMap(res.data);
    }

     /// Delete Document
     ///
     /// Delete a document by its unique ID. This endpoint deletes only the parent
     /// documents, its attributes and relations to other documents. Child documents
     /// **will not** be deleted.
     ///
     Future deleteDocument({required String collectionId, required String documentId}) async {
        final String path = '/database/collections/{collectionId}/documents/{documentId}'.replaceAll(RegExp('{collectionId}'), collectionId).replaceAll(RegExp('{documentId}'), documentId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: path, params: params, headers: headers);
        return  res.data;
    }
}