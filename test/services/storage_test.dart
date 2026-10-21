import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite/enums.dart' as enums;
import 'package:appwrite/src/enums.dart';
import 'package:appwrite/src/response.dart';
import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';

class MockClient extends Mock implements Client {
  Map<String, String> config = {'project': 'testproject'};
  String endPoint = 'https://localhost/v1';

  @override
  Future<Response> call(
    HttpMethod? method, {
    String? path = '',
    Map<String, String>? headers = const {},
    Map<String, dynamic>? params = const {},
    ResponseType? responseType,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#call, [method], {
        #path: path,
        #headers: headers,
        #params: params,
        #responseType: responseType,
      }),
      returnValue: Response(),
    );
  }

  @override
  Future webAuth(Uri? url, {String? callbackUrlScheme}) async {
    return super.noSuchMethod(
      Invocation.method(#webAuth, [url]),
      returnValue: 'done',
    );
  }

  @override
  Future<Response> chunkedUpload({
    String? path,
    Map<String, dynamic>? params,
    String? paramName,
    String? idParamName,
    Map<String, String>? headers,
    Function(UploadProgress)? onProgress,
    ResponseType? responseType,
    HttpMethod? method = HttpMethod.post,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#chunkedUpload, [], {
        #path: path,
        #params: params,
        #paramName: paramName,
        #idParamName: idParamName,
        #headers: headers,
        #method: method,
      }),
      returnValue: Response(data: {}),
    );
  }
}

void main() {
  group('Storage test', () {
    late MockClient client;
    late Storage storage;

    setUp(() {
      client = MockClient();
      storage = Storage(client);
    });

    test('test method listFiles()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'files': [],
      };

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await storage.listFiles(
        bucketId: "<BUCKET_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/storage/buckets/<BUCKET_ID>/files",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.FileList>());
    });

    test('test method createFile()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        'bucketId': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        '\$permissions': [],
        'name': "Pink.png",
        'folder': "photos/2026/",
        'key': "photos/2026/Pink.png",
        'signature': "5d529fd02b544198ae075bd57c1762bb",
        'mimeType': "image/png",
        'sizeOriginal': 17890,
        'sizeActual': 12345,
        'chunksTotal': 17890,
        'chunksUploaded': 17890,
        'encryption': true,
        'compression': "gzip",
      };

      when(
        client.chunkedUpload(
          path: anyNamed('path'),
          params: anyNamed('params'),
          paramName: anyNamed('paramName'),
          idParamName: anyNamed('idParamName'),
          headers: anyNamed('headers'),
          method: anyNamed('method'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await storage.createFile(
        bucketId: "<BUCKET_ID>",
        fileId: "<FILE_ID>",
        file: InputFile.fromPath(path: './image.png'),
      );
      final Map<String, dynamic> params = verify(
        client.chunkedUpload(
          path: "/storage/buckets/<BUCKET_ID>/files",
          params: captureAnyNamed('params'),
          paramName: anyNamed('paramName'),
          idParamName: anyNamed('idParamName'),
          headers: anyNamed('headers'),
          method: HttpMethod.post,
        ),
      ).captured.single;
      expect(params.keys, unorderedEquals(["fileId", "file"]));
      expect(response, isA<models.File>());
    });

    test('test method getFile()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        'bucketId': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        '\$permissions': [],
        'name': "Pink.png",
        'folder': "photos/2026/",
        'key': "photos/2026/Pink.png",
        'signature': "5d529fd02b544198ae075bd57c1762bb",
        'mimeType': "image/png",
        'sizeOriginal': 17890,
        'sizeActual': 12345,
        'chunksTotal': 17890,
        'chunksUploaded': 17890,
        'encryption': true,
        'compression': "gzip",
      };

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await storage.getFile(
        bucketId: "<BUCKET_ID>",
        fileId: "<FILE_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/storage/buckets/<BUCKET_ID>/files/<FILE_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.File>());
    });

    test('test method updateFile()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        'bucketId': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        '\$permissions': [],
        'name': "Pink.png",
        'folder': "photos/2026/",
        'key': "photos/2026/Pink.png",
        'signature': "5d529fd02b544198ae075bd57c1762bb",
        'mimeType': "image/png",
        'sizeOriginal': 17890,
        'sizeActual': 12345,
        'chunksTotal': 17890,
        'chunksUploaded': 17890,
        'encryption': true,
        'compression': "gzip",
      };

      when(
        client.call(
          HttpMethod.put,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await storage.updateFile(
        bucketId: "<BUCKET_ID>",
        fileId: "<FILE_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.put,
          path: "/storage/buckets/<BUCKET_ID>/files/<FILE_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<models.File>());
    });

    test('test method deleteFile()', () async {
      final data = '';

      when(
        client.call(
          HttpMethod.delete,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await storage.deleteFile(
        bucketId: "<BUCKET_ID>",
        fileId: "<FILE_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/storage/buckets/<BUCKET_ID>/files/<FILE_ID>",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
    });

    test('test method getFileDownload()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await storage.getFileDownload(
        bucketId: "<BUCKET_ID>",
        fileId: "<FILE_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/storage/buckets/<BUCKET_ID>/files/<FILE_ID>/download",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<Uint8List>());
    });

    test('test method getFilePreview()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await storage.getFilePreview(
        bucketId: "<BUCKET_ID>",
        fileId: "<FILE_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/storage/buckets/<BUCKET_ID>/files/<FILE_ID>/preview",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<Uint8List>());
    });

    test('test method getFileView()', () async {
      final Uint8List data = Uint8List.fromList([]);

      when(
        client.call(
          HttpMethod.get,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await storage.getFileView(
        bucketId: "<BUCKET_ID>",
        fileId: "<FILE_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/storage/buckets/<BUCKET_ID>/files/<FILE_ID>/view",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params.keys, isEmpty);
      expect(response, isA<Uint8List>());
    });
  });
}
