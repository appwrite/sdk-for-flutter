part of '../appwrite.dart';

/// The GraphQL API allows you to query and mutate your Appwrite server using
/// GraphQL.
class Graphql extends Service {
  final ClientAuth _client;

  /// Initializes a [Graphql] service
  // ignore: use_super_parameters
  Graphql(ClientAuth client)
      : _client = client,
        super(client);

  /// Execute a GraphQL mutation.
  Future query({required Map query}) async {
    const String apiPath = '/graphql';

    final Map<String, dynamic> apiParams = {
      'query': query,
    };

    final Map<String, String> apiHeaders = {
      'x-sdk-graphql': 'true',
      'content-type': 'application/json',
    };

    final res = await _client.call(HttpMethod.post,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return res.data;
  }

  /// Execute a GraphQL mutation.
  Future mutation({required Map query}) async {
    const String apiPath = '/graphql/mutation';

    final Map<String, dynamic> apiParams = {
      'query': query,
    };

    final Map<String, String> apiHeaders = {
      'x-sdk-graphql': 'true',
      'content-type': 'application/json',
    };

    final res = await _client.call(HttpMethod.post,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return res.data;
  }
}
