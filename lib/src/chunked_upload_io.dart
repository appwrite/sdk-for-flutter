import 'client.dart';
import 'dart:io' as io;
import 'enums.dart';
import 'package:http/http.dart' as http;
import 'response.dart';
import 'dart:math';
import 'input_file.dart';
import 'exception.dart';
import 'upload_progress.dart';

Future<Response> chunkedUpload({
  required Client client,
  required String path,
  required Map<String, dynamic> params,
  required String paramName,
  required String idParamName,
  required Map<String, String> headers,
  Function(UploadProgress)? onProgress,
}) async {
  InputFile file = params[paramName];
  if (file.path == null) {
    throw AppwriteException("File path must be provided for dart:io");
  }
  io.File iofile = io.File(file.path!);
  final size = await iofile.length();

  late Response res;
  if (size <= Client.CHUNK_SIZE) {
    params[paramName] = await http.MultipartFile.fromPath(paramName, file.path!, filename: file.filename);
    return client.call(
      HttpMethod.post,
      path: path,
      params: params,
      headers: headers,
    );
  }

  var offset = 0;
  if(idParamName.isNotEmpty && params[idParamName] != 'unique()') {
    //make a request to check if a file already exists
    try {
      res = await client.call(
        HttpMethod.get,
        path: path + '/' + params[idParamName],
        headers: headers,
      );
      final int chunksUploaded = res.data['chunksUploaded'] as int;
      offset = min(size, chunksUploaded * Client.CHUNK_SIZE);
    } on AppwriteException catch (_) {}
  }
  // read chunk and upload each chunk
  final raf = iofile.openSync(mode: io.FileMode.read);

  while (offset < size) {
    raf.setPositionSync(offset);
    final chunk = raf.readSync(Client.CHUNK_SIZE);
    params[paramName] =
        http.MultipartFile.fromBytes(paramName, chunk, filename: file.filename);
    headers['content-range'] =
        'bytes $offset-${min<int>(((offset + Client.CHUNK_SIZE) - 1), size)}/$size';
    res = await client.call(HttpMethod.post,
        path: path, headers: headers, params: params);
    offset += Client.CHUNK_SIZE;
    if(offset < size) {
      headers['x-appwrite-id'] = res.data['\$id'];
    }
    final progress = UploadProgress(
      $id: res.data['\$id'] ?? '',
      progress: min(offset-1,size)/size * 100,
      sizeUploaded: min(offset-1,size),
      chunksTotal: res.data['chunksTotal'] ?? 0,
      chunksUploaded: res.data['chunksUploaded'] ?? 0,
    );
    onProgress?.call(progress);
  }
  raf.close();
  return res;
}
