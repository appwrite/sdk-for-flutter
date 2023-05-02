part of appwrite;

/// The GraphQL API allows you to query and mutate your Appwrite server using
/// GraphQL.
class Graphql extends Service {
  Graphql(super.client);

  /// GraphQL Endpoint
  ///
  /// Execute a GraphQL mutation.
  ///
  Future query({required Map query}) async {
    const String path = '/graphql';

    final Map<String, dynamic> params = {
      'query': query,
    };

    final Map<String, String> headers = {
      'x-sdk-graphql': 'true',
      'content-type': 'application/json',
    };

    final cacheModel = '';
    final cacheKey = '';
    final cacheResponseIdKey = '\$id';
    final cacheResponseContainerKey = '';

    final res = await client.call(withCacheParams(
      CallParams(
        HttpMethod.post,
        path,
        params: params,
        headers: headers,
      ),
      CacheParams(
        model: cacheModel,
        key: cacheKey,
        responseIdKey: cacheResponseIdKey,
        responseContainerKey: cacheResponseContainerKey,
      ),
    ));

    return res.data;
  }

  /// GraphQL Endpoint
  ///
  /// Execute a GraphQL mutation.
  ///
  Future mutation({required Map query}) async {
    const String path = '/graphql/mutation';

    final Map<String, dynamic> params = {
      'query': query,
    };

    final Map<String, String> headers = {
      'x-sdk-graphql': 'true',
      'content-type': 'application/json',
    };

    final cacheModel = '';
    final cacheKey = '';
    final cacheResponseIdKey = '\$id';
    final cacheResponseContainerKey = '';

    final res = await client.call(withCacheParams(
      CallParams(
        HttpMethod.post,
        path,
        params: params,
        headers: headers,
      ),
      CacheParams(
        model: cacheModel,
        key: cacheKey,
        responseIdKey: cacheResponseIdKey,
        responseContainerKey: cacheResponseContainerKey,
      ),
    ));

    return res.data;
  }
}
