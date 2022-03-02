import 'response.dart';
import 'client.dart';
import 'upload_progress.dart';

Future<Response> chunkedUpload({
  required Client client,
  required String path,
  required Map<String, dynamic> params,
  required String paramName,
  required Map<String, String> headers,
  Function(UploadProgress)? onProgress,
}) =>
    throw UnsupportedError('Cannot redirect to url without dart:html');
