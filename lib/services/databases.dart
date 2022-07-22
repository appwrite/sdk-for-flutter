part of appwrite;

     /// The Databases service allows you to create structured collections of
     /// documents, query and filter lists of documents
class Databases extends Service {
    Databases(Client client, {required this.databaseId}): super(client);
    String databaseId;

     /// List Documents
     Future<models.DocumentList> listDocuments({required String collectionId, List? queries, int? limit, int? offset, String? cursor, String? cursorDirection, List? orderAttributes, List? orderTypes}) async {
        final String path = '/databases/{databaseId}/collections/{collectionId}/documents'.replaceAll('{databaseId}', databaseId).replaceAll('{collectionId}', collectionId);

        final Map<String, dynamic> params = {
            'queries': queries,
'limit': limit,
'offset': offset,
'cursor': cursor,
'cursorDirection': cursorDirection,
'orderAttributes': orderAttributes,
'orderTypes': orderTypes,

            
        };

        final Map<String, String> headers = {
                        'content-type': 'application/json',

        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.DocumentList.fromMap(res.data);


    }

     /// Create Document
     Future<models.Document> createDocument({required String collectionId, String documentId = "unique()", required Map data, List? read, List? write}) async {
        final String path = '/databases/{databaseId}/collections/{collectionId}/documents'.replaceAll('{databaseId}', databaseId).replaceAll('{collectionId}', collectionId);

        final Map<String, dynamic> params = {
            
            'documentId': documentId,
'data': data,
'read': read,
'write': write,

        };

        final Map<String, String> headers = {
                        'content-type': 'application/json',

        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Document.fromMap(res.data);


    }

     /// Get Document
     Future<models.Document> getDocument({required String collectionId, required String documentId}) async {
        final String path = '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}'.replaceAll('{databaseId}', databaseId).replaceAll('{collectionId}', collectionId).replaceAll('{documentId}', documentId);

        final Map<String, dynamic> params = {
            
            
        };

        final Map<String, String> headers = {
                        'content-type': 'application/json',

        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.Document.fromMap(res.data);


    }

     /// Update Document
     Future<models.Document> updateDocument({required String collectionId, required String documentId, Map? data, List? read, List? write}) async {
        final String path = '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}'.replaceAll('{databaseId}', databaseId).replaceAll('{collectionId}', collectionId).replaceAll('{documentId}', documentId);

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
     Future deleteDocument({required String collectionId, required String documentId}) async {
        final String path = '/databases/{databaseId}/collections/{collectionId}/documents/{documentId}'.replaceAll('{databaseId}', databaseId).replaceAll('{collectionId}', collectionId).replaceAll('{documentId}', documentId);

        final Map<String, dynamic> params = {
            
            
        };

        final Map<String, String> headers = {
                        'content-type': 'application/json',

        };

        final res = await client.call(HttpMethod.delete, path: path, params: params, headers: headers);

        return  res.data;


    }
}
