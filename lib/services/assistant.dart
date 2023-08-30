part of appwrite;

class Assistant extends Service {
    /// Initializes a [Assistant] service
    Assistant(super.client);

    /// Ask Query
    ///
    Future chat({required String prompt}) async {
        const String apiPath = '/console/assistant';

        final Map<String, dynamic> params = {
            'prompt': prompt,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: params, headers: headers);

        return  res.data;

    }
}