part of appwrite;

/// The Storage service allows you to manage your project files.
class Storage extends Service {
  Storage(Client client) : super(client);

  /// List Files
  ///
  /// Get a list of all the user files. You can use the query params to filter
  /// your results. On admin mode, this endpoint will return a list of all of the
  /// project's files. [Learn more about different API modes](/docs/admin).
  ///
  Future<models.FileList> listFiles(
      {required String bucketId,
      String? search,
      int? limit,
      int? offset,
      String? cursor,
      String? cursorDirection,
      String? orderType}) async {
    final String path =
        '/storage/buckets/{bucketId}/files'.replaceAll('{bucketId}', bucketId);

    final Map<String, dynamic> params = {
      'search': search,
      'limit': limit,
      'offset': offset,
      'cursor': cursor,
      'cursorDirection': cursorDirection,
      'orderType': orderType,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: path, params: params, headers: headers);

    return models.FileList.fromMap(res.data);
  }

  /// Create File
  ///
  /// Create a new file. Before using this route, you should create a new bucket
  /// resource using either a [server
  /// integration](/docs/server/database#storageCreateBucket) API or directly
  /// from your Appwrite console.
  ///
  /// Larger files should be uploaded using multiple requests with the
  /// [content-range](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Range)
  /// header to send a partial request with a maximum supported chunk of `5MB`.
  /// The `content-range` header values should always be in bytes.
  ///
  /// When the first request is sent, the server will return the **File** object,
  /// and the subsequent part request must include the file's **id** in
  /// `x-appwrite-id` header to allow the server to know that the partial upload
  /// is for the existing file and not for a new one.
  ///
  /// If you're creating a new file using one of the Appwrite SDKs, all the
  /// chunking logic will be managed by the SDK internally.
  ///
  ///
  Future<models.File> createFile(
      {required String bucketId,
      required String fileId,
      required InputFile file,
      List? read,
      List? write,
      Function(UploadProgress)? onProgress}) async {
    final String path =
        '/storage/buckets/{bucketId}/files'.replaceAll('{bucketId}', bucketId);

    final Map<String, dynamic> params = {
      'fileId': fileId,
      'file': file,
      'read': read,
      'write': write,
    };

    final Map<String, String> headers = {
      'content-type': 'multipart/form-data',
    };

    String idParamName = '';
    idParamName = 'fileId';
    final paramName = 'file';
    final res = await client.chunkedUpload(
      path: path,
      params: params,
      paramName: paramName,
      idParamName: idParamName,
      headers: headers,
      onProgress: onProgress,
    );

    return models.File.fromMap(res.data);
  }

  /// Get File
  ///
  /// Get a file by its unique ID. This endpoint response returns a JSON object
  /// with the file metadata.
  ///
  Future<models.File> getFile(
      {required String bucketId, required String fileId}) async {
    final String path = '/storage/buckets/{bucketId}/files/{fileId}'
        .replaceAll('{bucketId}', bucketId)
        .replaceAll('{fileId}', fileId);

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: path, params: params, headers: headers);

    return models.File.fromMap(res.data);
  }

  /// Update File
  ///
  /// Update a file by its unique ID. Only users with write permissions have
  /// access to update this resource.
  ///
  Future<models.File> updateFile(
      {required String bucketId,
      required String fileId,
      List? read,
      List? write}) async {
    final String path = '/storage/buckets/{bucketId}/files/{fileId}'
        .replaceAll('{bucketId}', bucketId)
        .replaceAll('{fileId}', fileId);

    final Map<String, dynamic> params = {
      'read': read,
      'write': write,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.put,
        path: path, params: params, headers: headers);

    return models.File.fromMap(res.data);
  }

  /// Delete File
  ///
  /// Delete a file by its unique ID. Only users with write permissions have
  /// access to delete this resource.
  ///
  Future deleteFile({required String bucketId, required String fileId}) async {
    final String path = '/storage/buckets/{bucketId}/files/{fileId}'
        .replaceAll('{bucketId}', bucketId)
        .replaceAll('{fileId}', fileId);

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.delete,
        path: path, params: params, headers: headers);

    return res.data;
  }

  /// Get File for Download
  ///
  /// Get a file content by its unique ID. The endpoint response return with a
  /// 'Content-Disposition: attachment' header that tells the browser to start
  /// downloading the file to user downloads directory.
  ///
  Future<Uint8List> getFileDownload(
      {required String bucketId, required String fileId}) async {
    final String path = '/storage/buckets/{bucketId}/files/{fileId}/download'
        .replaceAll('{bucketId}', bucketId)
        .replaceAll('{fileId}', fileId);

    final Map<String, dynamic> params = {
      'project': client.config['project'],
    };

    final res = await client.call(HttpMethod.get,
        path: path, params: params, responseType: ResponseType.bytes);
    return res.data;
  }

  /// Get File Preview
  ///
  /// Get a file preview image. Currently, this method supports preview for image
  /// files (jpg, png, and gif), other supported formats, like pdf, docs, slides,
  /// and spreadsheets, will return the file icon image. You can also pass query
  /// string arguments for cutting and resizing your preview image. Preview is
  /// supported only for image files smaller than 10MB.
  ///
  Future<Uint8List> getFilePreview(
      {required String bucketId,
      required String fileId,
      int? width,
      int? height,
      String? gravity,
      int? quality,
      int? borderWidth,
      String? borderColor,
      int? borderRadius,
      double? opacity,
      int? rotation,
      String? background,
      String? output}) async {
    final String path = '/storage/buckets/{bucketId}/files/{fileId}/preview'
        .replaceAll('{bucketId}', bucketId)
        .replaceAll('{fileId}', fileId);

    final Map<String, dynamic> params = {
      'width': width,
      'height': height,
      'gravity': gravity,
      'quality': quality,
      'borderWidth': borderWidth,
      'borderColor': borderColor,
      'borderRadius': borderRadius,
      'opacity': opacity,
      'rotation': rotation,
      'background': background,
      'output': output,
      'project': client.config['project'],
    };

    final res = await client.call(HttpMethod.get,
        path: path, params: params, responseType: ResponseType.bytes);
    return res.data;
  }

  /// Get File for View
  ///
  /// Get a file content by its unique ID. This endpoint is similar to the
  /// download method but returns with no  'Content-Disposition: attachment'
  /// header.
  ///
  Future<Uint8List> getFileView(
      {required String bucketId, required String fileId}) async {
    final String path = '/storage/buckets/{bucketId}/files/{fileId}/view'
        .replaceAll('{bucketId}', bucketId)
        .replaceAll('{fileId}', fileId);

    final Map<String, dynamic> params = {
      'project': client.config['project'],
    };

    final res = await client.call(HttpMethod.get,
        path: path, params: params, responseType: ResponseType.bytes);
    return res.data;
  }
}
