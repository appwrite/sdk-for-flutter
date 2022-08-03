import 'package:http/http.dart' as http;
import 'exception.dart';
import 'response.dart';
import 'dart:convert';
import 'enums.dart';

class ClientMixin {
  http.BaseRequest prepareRequest(
    HttpMethod method, {
    required Uri uri,
    required Map<String, String> headers,
    required Map<String, dynamic> params,
  }) {
    if (params.isNotEmpty) {
      params.removeWhere((key, value) => value == null);
    }

    http.BaseRequest request = http.Request(method.name(), uri);
    if (headers['content-type'] == 'multipart/form-data') {
      request = http.MultipartRequest(method.name(), uri);
      if (params.isNotEmpty) {
        params.forEach((key, value) {
          if (value is http.MultipartFile) {
            (request as http.MultipartRequest).files.add(value);
          } else {
            if (value is List) {
              value.asMap().forEach((i, v) {
                (request as http.MultipartRequest)
                    .fields
                    .addAll({"$key[$i]": v.toString()});
              });
            } else {
              (request as http.MultipartRequest)
                  .fields
                  .addAll({key: value.toString()});
            }
          }
        });
      }
    } else if (method == HttpMethod.get) {
      if (params.isNotEmpty) {
        params = params.map((key, value) {
          if (value is int || value is double) {
            return MapEntry(key, value.toString());
          }
          if (value is List) {
            return MapEntry(key + "[]", value);
          }
          return MapEntry(key, value);
        });
      }
      uri = Uri(
          fragment: uri.fragment,
          path: uri.path,
          host: uri.host,
          scheme: uri.scheme,
          queryParameters: params,
          port: uri.port);
      request = http.Request(method.name(), uri);
    } else {
      (request as http.Request).body = jsonEncode(params);
    }

    request.headers.addAll(headers);
    return request;
  }

  Response prepareResponse(http.Response res, {ResponseType? responseType}) {
    responseType ??= ResponseType.json;
    if (res.statusCode >= 400) {
      if ((res.headers['content-type'] ?? '').contains('application/json')) {
        final response = json.decode(res.body);
        throw AppwriteException(
          response['message'],
          response['code'],
          response['type'],
          response,
        );
      } else {
        throw AppwriteException(res.body);
      }
    }
    dynamic data;
    if ((res.headers['content-type'] ?? '').contains('application/json')) {
      if (responseType == ResponseType.json) {
        data = json.decode(res.body);
      } else if (responseType == ResponseType.bytes) {
        data = res.bodyBytes;
      } else {
        data = res.body;
      }
    } else {
      if (responseType == ResponseType.bytes) {
        data = res.bodyBytes;
      } else {
        data = res.body;
      }
    }
    return Response(data: data);
  }

  Future<http.Response> toResponse(
      http.StreamedResponse streamedResponse) async {
    if (streamedResponse.statusCode == 204) {
      return http.Response(
        '',
        streamedResponse.statusCode,
        headers: streamedResponse.headers.map((k, v) =>
            k.toLowerCase() == 'content-type'
                ? MapEntry(k, 'text/plain')
                : MapEntry(k, v)),
        request: streamedResponse.request,
        isRedirect: streamedResponse.isRedirect,
        persistentConnection: streamedResponse.persistentConnection,
        reasonPhrase: streamedResponse.reasonPhrase,
      );
    } else {
      return await http.Response.fromStream(streamedResponse);
    }
  }
}
