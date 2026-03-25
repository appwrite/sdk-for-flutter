part of '../appwrite.dart';

class VectorsDB extends Service {
  /// Initializes a [VectorsDB] service
  VectorsDB(super.client);

  Future<models.TransactionList> listTransactions({List<String>? queries}) async {
    const String apiPath = '/vectorsdb/transactions';

        final Map<String, dynamic> apiParams = {
            if (queries != null) 'queries': queries,

        };

        final Map<String, String> apiHeaders = {

        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.TransactionList.fromMap(res.data);

  }

  Future<models.Transaction> createTransaction({int? ttl}) async {
    const String apiPath = '/vectorsdb/transactions';

        final Map<String, dynamic> apiParams = {
            if (ttl != null) 'ttl': ttl,

        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Transaction.fromMap(res.data);

  }

  Future<models.Transaction> getTransaction({required String transactionId}) async {
    final String apiPath = '/vectorsdb/transactions/{transactionId}'.replaceAll('{transactionId}', transactionId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {

        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Transaction.fromMap(res.data);

  }

  Future<models.Transaction> updateTransaction({required String transactionId, bool? commit, bool? rollback}) async {
    final String apiPath = '/vectorsdb/transactions/{transactionId}'.replaceAll('{transactionId}', transactionId);

        final Map<String, dynamic> apiParams = {
            if (commit != null) 'commit': commit,

            if (rollback != null) 'rollback': rollback,

        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Transaction.fromMap(res.data);

  }

  Future deleteTransaction({required String transactionId}) async {
    final String apiPath = '/vectorsdb/transactions/{transactionId}'.replaceAll('{transactionId}', transactionId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

  }

  Future<models.Transaction> createOperations({required String transactionId, List<Map>? operations}) async {
    final String apiPath = '/vectorsdb/transactions/{transactionId}/operations'.replaceAll('{transactionId}', transactionId);

        final Map<String, dynamic> apiParams = {
            if (operations != null) 'operations': operations,

        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Transaction.fromMap(res.data);

  }

  Future<models.DocumentList> listDocuments({required String databaseId, required String collectionId, List<String>? queries, String? transactionId, bool? total, int? ttl}) async {
    final String apiPath = '/vectorsdb/{databaseId}/collections/{collectionId}/documents'.replaceAll('{databaseId}', databaseId).replaceAll('{collectionId}', collectionId);

        final Map<String, dynamic> apiParams = {
            if (queries != null) 'queries': queries,

            if (transactionId != null) 'transactionId': transactionId,

            if (total != null) 'total': total,

            if (ttl != null) 'ttl': ttl,

        };

        final Map<String, String> apiHeaders = {

        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.DocumentList.fromMap(res.data);

  }

  Future<models.Document> createDocument({required String databaseId, required String collectionId, required String documentId, required Map data, List<String>? permissions}) async {
    final String apiPath = '/vectorsdb/{databaseId}/collections/{collectionId}/documents'.replaceAll('{databaseId}', databaseId).replaceAll('{collectionId}', collectionId);

        final Map<String, dynamic> apiParams = {
            'documentId': documentId,

            'data': data,

            if (permissions != null) 'permissions': permissions,

        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Document.fromMap(res.data);

  }

  Future<models.Document> getDocument({required String databaseId, required String collectionId, required String documentId, List<String>? queries, String? transactionId}) async {
    final String apiPath = '/vectorsdb/{databaseId}/collections/{collectionId}/documents/{documentId}'.replaceAll('{databaseId}', databaseId).replaceAll('{collectionId}', collectionId).replaceAll('{documentId}', documentId);

        final Map<String, dynamic> apiParams = {
            if (queries != null) 'queries': queries,

            if (transactionId != null) 'transactionId': transactionId,

        };

        final Map<String, String> apiHeaders = {

        };

        final res = await client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Document.fromMap(res.data);

  }

  Future<models.Document> upsertDocument({required String databaseId, required String collectionId, required String documentId, Map? data, List<String>? permissions, String? transactionId}) async {
    final String apiPath = '/vectorsdb/{databaseId}/collections/{collectionId}/documents/{documentId}'.replaceAll('{databaseId}', databaseId).replaceAll('{collectionId}', collectionId).replaceAll('{documentId}', documentId);

        final Map<String, dynamic> apiParams = {
            if (data != null) 'data': data,

            if (permissions != null) 'permissions': permissions,

            if (transactionId != null) 'transactionId': transactionId,

        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Document.fromMap(res.data);

  }

  Future<models.Document> updateDocument({required String databaseId, required String collectionId, required String documentId, Map? data, List<String>? permissions, String? transactionId}) async {
    final String apiPath = '/vectorsdb/{databaseId}/collections/{collectionId}/documents/{documentId}'.replaceAll('{databaseId}', databaseId).replaceAll('{collectionId}', collectionId).replaceAll('{documentId}', documentId);

        final Map<String, dynamic> apiParams = {
            if (data != null) 'data': data,

            if (permissions != null) 'permissions': permissions,

            if (transactionId != null) 'transactionId': transactionId,

        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Document.fromMap(res.data);

  }

  Future deleteDocument({required String databaseId, required String collectionId, required String documentId, String? transactionId}) async {
    final String apiPath = '/vectorsdb/{databaseId}/collections/{collectionId}/documents/{documentId}'.replaceAll('{databaseId}', databaseId).replaceAll('{collectionId}', collectionId).replaceAll('{documentId}', documentId);

        final Map<String, dynamic> apiParams = {
            if (transactionId != null) 'transactionId': transactionId,

        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

  }
}