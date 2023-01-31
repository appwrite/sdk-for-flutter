part of appwrite;

class GraphQL extends Service {
    GraphQL(super.client);

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
            'x-sdk-graphql': 'true',            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return  res.data;

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
            'x-sdk-graphql': 'true',            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return  res.data;

    }
}