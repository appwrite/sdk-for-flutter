part of '../appwrite.dart';

class Presences extends Service {
  final ClientAuth _client;

  /// Initializes a [Presences] service
  // ignore: use_super_parameters
  Presences(ClientAuth client)
      : _client = client,
        super(client);

  /// List presence logs. Expired entries are filtered out automatically.
  /// 
  Future<models.PresenceList> list({List<String>? queries, bool? total, int? ttl}) async {
    const String apiPath = '/presences';

        final Map<String, dynamic> apiParams = {
            if (queries != null) 'queries': queries,

            if (total != null) 'total': total,

            if (ttl != null) 'ttl': ttl,

        };

        final Map<String, String> apiHeaders = {

        };

        final res = await _client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.PresenceList.fromMap(res.data);

  }

  /// Get a presence log by its unique ID. Entries whose `expiresAt` is in the
  /// past are treated as not found.
  /// 
  Future<models.Presence> get({required String presenceId}) async {
    final String apiPath = '/presences/{presenceId}'.replaceAll('{presenceId}', presenceId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {

        };

        final res = await _client.call(HttpMethod.get, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Presence.fromMap(res.data);

  }

  /// Create or update a presence log by its user ID.
  /// 
  Future<models.Presence> upsert({required String presenceId, required String status, List<String>? permissions, String? expiresAt, Map? metadata}) async {
    final String apiPath = '/presences/{presenceId}'.replaceAll('{presenceId}', presenceId);

        final Map<String, dynamic> apiParams = {
            'status': status,

            if (permissions != null) 'permissions': permissions,

            if (expiresAt != null) 'expiresAt': expiresAt,

            if (metadata != null) 'metadata': metadata,

        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await _client.call(HttpMethod.put, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Presence.fromMap(res.data);

  }

  /// Update a presence log by its unique ID. Using the patch method you can pass
  /// only specific fields that will get updated.
  /// 
  Future<models.Presence> update({required String presenceId, String? status, String? expiresAt, Map? metadata, List<String>? permissions, bool? purge}) async {
    final String apiPath = '/presences/{presenceId}'.replaceAll('{presenceId}', presenceId);

        final Map<String, dynamic> apiParams = {
            if (status != null) 'status': status,

            if (expiresAt != null) 'expiresAt': expiresAt,

            if (metadata != null) 'metadata': metadata,

            if (permissions != null) 'permissions': permissions,

            if (purge != null) 'purge': purge,

        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await _client.call(HttpMethod.patch, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Presence.fromMap(res.data);

  }

  /// Delete a presence log by its unique ID.
  /// 
  Future delete({required String presenceId}) async {
    final String apiPath = '/presences/{presenceId}'.replaceAll('{presenceId}', presenceId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await _client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

  }
}
