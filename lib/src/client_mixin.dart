import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:string_scanner/string_scanner.dart';

import 'exception.dart';
import 'response.dart';
import 'dart:convert';
import 'dart:developer';
import 'enums.dart';
import '../payload.dart';

mixin ClientMixin {
  final _token = RegExp(r'[^()<>@,;:"\\/[\]?={} \t\x00-\x1F\x7F]+');
  final _whitespace = RegExp(r'(?:(?:\r\n)?[ \t]+)*');
  final _quotedString = RegExp(r'"(?:[^"\x00-\x1F\x7F]|\\.)*"');
  final _quotedPair = RegExp(r'\\(.)');

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
        params = params.map((key, value){
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

  Future<Response> prepareResponse(http.Response res, {ResponseType? responseType}) async {
    responseType ??= ResponseType.json;

    String? warnings = res.headers['x-appwrite-warning'];
    if (warnings != null) {
      warnings.split(';').forEach((warning) => log('Warning: $warning'));
    }

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
    } else if((res.headers['content-type'] ?? '').contains('multipart/form-data')) {
      data = await _parseMultipart(res.headers['content-type']!, Stream.value(res.bodyBytes));
      return Response(data: data);
    } else {
      if (responseType == ResponseType.bytes) {
        data = res.bodyBytes;
      } else {
        data = res.body;
      }
    }
    return Response(data: data);
  }

  Future<http.Response> toResponse(http.StreamedResponse streamedResponse) async {
    if(streamedResponse.statusCode == 204) {
        return http.Response('',
          streamedResponse.statusCode,
          headers: streamedResponse.headers.map((k,v) => k.toLowerCase()=='content-type' ? MapEntry(k, 'text/plain') : MapEntry(k,v)),
          request: streamedResponse.request,
          isRedirect: streamedResponse.isRedirect,
          persistentConnection: streamedResponse.persistentConnection,
          reasonPhrase: streamedResponse.reasonPhrase,
        );
      } else {
        return await http.Response.fromStream(streamedResponse);
      }
  }

  Future<List<int>> _decodeMimeMultipart(MimeMultipart part) async {
    List<int> result = [];

    await for (var chunk in part) {
      result.addAll(chunk);
    }

    return result;
  }

  /// Parse multipart forma data
  Future<Map<String, dynamic>> _parseMultipart(
      String header, Stream<List<int>> body) async {
    final data = await _parts(header, body)
        .map<_FormData?>((part) {
          final rawDisposition = part.headers['content-disposition'];
          if (rawDisposition == null) return null;

          final formDataParams =
              _parseFormDataContentDisposition(rawDisposition);
          if (formDataParams == null) return null;

          final name = formDataParams['name'];
          if (name == null) return null;

          final filename = formDataParams['filename'];
          dynamic value;
          if (name == 'responseBody') {
            return _FormData._(name, filename, part);
          } else if (filename != null) {
            value = {
              "file": part,
              "filename": filename,
              "mimeType": part.headers['Content-Type'],
            };
          } else {
            value = utf8.decodeStream(part);
          }
          return _FormData._(name, filename, value);
        })
        .where((data) => data != null)
        .toList();
    final Map<String, dynamic> out = {};
    for (final item in data) {
      if (item!.name == 'responseBody') {
        out[item.name] =
            Payload.fromBinary(data: await _decodeMimeMultipart(item.value), filename: item.filename);
      } else {
        out[item.name] = await item.value;
      }
    }
    return out;
  }

  Stream<MimeMultipart> _parts(String header, Stream<List<int>> body) {
    final boundary = _extractBoundary(header);
    if (boundary == null) {
      throw Exception('Not a multipart request');
    }
    return MimeMultipartTransformer(boundary).bind(body!);
  }

  String? _extractBoundary(String header) {
    final contentType = MediaType.parse(header);
    if (contentType.type != 'multipart') return null;

    return contentType.parameters['boundary'];
  }

  /// Parses a `content-disposition: form-data; arg1="val1"; ...` header.
  Map<String, String>? _parseFormDataContentDisposition(String header) {
    final scanner = StringScanner(header);

    scanner
      ..scan(_whitespace)
      ..expect(_token);
    if (scanner.lastMatch![0] != 'form-data') return null;

    final params = <String, String>{};

    while (scanner.scan(';')) {
      scanner
        ..scan(_whitespace)
        ..scan(_token);
      final key = scanner.lastMatch![0]!;
      scanner.expect('=');

      String value;
      if (scanner.scan(_token)) {
        value = scanner.lastMatch![0]!;
      } else {
        scanner.expect(_quotedString, name: 'quoted string');
        final string = scanner.lastMatch![0]!;

        value = string
            .substring(1, string.length - 1)
            .replaceAllMapped(_quotedPair, (match) => match[1]!);
      }

      scanner.scan(_whitespace);
      params[key] = value;
    }

    scanner.expectDone();
    return params;
  }
}

class _FormData {
  final String name;
  final dynamic value;
  final String? filename;

  _FormData._(this.name, this.filename, this.value);
}