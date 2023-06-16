import 'package:http/http.dart' as http;

import '../call_params.dart';
import '../client_mixin.dart';
import '../exception.dart';
import '../response.dart';
import 'call_handler.dart';

const endpointKey = 'endpoint';

String getEndpoint(CallParams params) {
  final endpoint = params.context[endpointKey];
  if (endpoint == null) return 'https://HOSTNAME/v1';
  return endpoint as String;
}

CallParams withEndpoint(CallParams params, String endpoint) {
  params.context[endpointKey] = endpoint;
  return params;
}

class HttpCallHandler extends CallHandler with ClientMixin {
  final http.Client client;

  HttpCallHandler(this.client);

  @override
  Future<Response> handleCall(CallParams params) async {
    final endpoint = getEndpoint(params);

    late http.Response res;
    http.BaseRequest request = prepareRequest(
      params.method,
      uri: Uri.parse(endpoint + params.path),
      headers: params.headers,
      params: params.params,
    );

    try {
      final streamedResponse = await client.send(request);
      res = await toResponse(streamedResponse);

      return prepareResponse(res, responseType: params.responseType);
    } catch (e) {
      if (e is AppwriteException) {
        rethrow;
      }
      throw AppwriteException(e.toString());
    }
  }
}
