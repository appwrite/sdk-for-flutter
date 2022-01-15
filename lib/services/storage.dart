part of appwrite;

class Storage extends Service {
  Storage(Client client) : super(client);

  /// List Files
  ///
  /// Get a list of all the user files. You can use the query params to filter
  /// your results. On admin mode, this endpoint will return a list of all of the
  /// project's files. [Learn more about different API modes](/docs/admin).
  ///
  Future<models.FileList> listFiles(
      {String? search,
      int? limit,
      int? offset,
      String? cursor,
      String? cursorDirection,
      OrderType? orderType}) async {
    final String path = '/storage/files';

    final Map<String, dynamic> params = {
      'search': search,
      'limit': limit,
      'offset': offset,
      'cursor': cursor,
      'cursorDirection': cursorDirection,
      'orderType': orderType != null ? orderType.name : null,
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
  /// Create a new file. The user who creates the file will automatically be
  /// assigned to read and write access unless he has passed custom values for
  /// read and write arguments.
  ///
  Future<models.File> createFile(
      {required String fileId,
      required http.MultipartFile file,
      List? read,
      List? write}) async {
    final String path = '/storage/files';

    final Map<String, dynamic> params = {
      'fileId': fileId,
      'file': file,
      'read': read,
      'write': write,
    };

    final Map<String, String> headers = {
      'content-type': 'multipart/form-data',
    };

    final res = await client.call(HttpMethod.post,
        path: path, params: params, headers: headers);
    return models.File.fromMap(res.data);
  }

  /// Get File
  ///
  /// Get a file by its unique ID. This endpoint response returns a JSON object
  /// with the file metadata.
  ///
  Future<models.File> getFile({required String fileId}) async {
    final String path =
        '/storage/files/{fileId}'.replaceAll('{fileId}', fileId);

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
      {required String fileId, required List read, required List write}) async {
    final String path =
        '/storage/files/{fileId}'.replaceAll('{fileId}', fileId);

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
  Future deleteFile({required String fileId}) async {
    final String path =
        '/storage/files/{fileId}'.replaceAll('{fileId}', fileId);

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
  Future<Uint8List> getFileDownload({required String fileId}) async {
    final String path =
        '/storage/files/{fileId}/download'.replaceAll('{fileId}', fileId);

    final Map<String, dynamic> params = {
      'project': client.config['project'],
    };

    params.keys.forEach((key) {
      if (params[key] is int || params[key] is double) {
        params[key] = params[key].toString();
      }
    });

    final res = await client.call(HttpMethod.get,
        path: path, params: params, responseType: ResponseType.bytes);
    return res.data;
  }

  /// Get File Preview
  ///
  /// Get a file preview image. Currently, this method supports preview for image
  /// files (jpg, png, and gif), other supported formats, like pdf, docs, slides,
  /// and spreadsheets, will return the file icon image. You can also pass query
  /// string arguments for cutting and resizing your preview image.
  ///
  Future<Uint8List> getFilePreview(
      {required String fileId,
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
    final String path =
        '/storage/files/{fileId}/preview'.replaceAll('{fileId}', fileId);

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

    params.keys.forEach((key) {
      if (params[key] is int || params[key] is double) {
        params[key] = params[key].toString();
      }
    });

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
  Future<Uint8List> getFileView({required String fileId}) async {
    final String path =
        '/storage/files/{fileId}/view'.replaceAll('{fileId}', fileId);

    final Map<String, dynamic> params = {
      'project': client.config['project'],
    };

    params.keys.forEach((key) {
      if (params[key] is int || params[key] is double) {
        params[key] = params[key].toString();
      }
    });

    final res = await client.call(HttpMethod.get,
        path: path, params: params, responseType: ResponseType.bytes);
    return res.data;
  }
}
