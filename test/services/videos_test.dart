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
  group('Videos test', () {
    late MockClient client;
    late Videos videos;

    setUp(() {
      client = MockClient();
      videos = Videos(client);
    });

    test('test method list()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'videos': [],
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

      final response = await videos.list(
        queries: [],
        total: false,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "queries": isA<List>(),
        "total": false,
      });
      expect(response, isA<models.VideoList>());
    });

    test('test method create()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        '\$permissions': [],
        'bucketId': "5e5ea5c16897e",
        'fileId': "d5fg5ehg1c168g7c",
        'name': "Product demo",
        'size': 23647142,
        'format': "MPEG-4",
        'duration': 92810,
        'width': 960,
        'height': 544,
        'aspectRatio': "16:9",
        'videoCodec': "h264",
        'videoFormat': "AVC",
        'videoFormatProfile': "Baseline@L3.1",
        'videoBitRate': 564790,
        'videoFrameRate': 29.97,
        'videoFrameRateMode': "CFR",
        'audioCodec': "aac",
        'audioFormat': "AAC",
        'audioBitRate': 127999,
        'audioSampleRate': 48000,
        'timelineStatus': "ready",
        'timelineError':
            "The requested file is not a valid video or audio file (ffprobe: Invalid data found when processing input)",
      };

      when(
        client.call(
          HttpMethod.post,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await videos.create(
        videoId: "<VIDEO_ID>",
        bucketId: "<BUCKET_ID>",
        fileId: "<FILE_ID>",
        name: "<NAME>",
        permissions: [],
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/videos",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "videoId": "<VIDEO_ID>",
        "bucketId": "<BUCKET_ID>",
        "fileId": "<FILE_ID>",
        "name": "<NAME>",
        "permissions": isA<List>(),
      });
      expect(response, isA<models.Video>());
    });

    test('test method listCodecs()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'codecs': [],
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

      final response = await videos.listCodecs();
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/codecs",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<models.VideoCodecList>());
    });

    test('test method get()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        '\$permissions': [],
        'bucketId': "5e5ea5c16897e",
        'fileId': "d5fg5ehg1c168g7c",
        'name': "Product demo",
        'size': 23647142,
        'format': "MPEG-4",
        'duration': 92810,
        'width': 960,
        'height': 544,
        'aspectRatio': "16:9",
        'videoCodec': "h264",
        'videoFormat': "AVC",
        'videoFormatProfile': "Baseline@L3.1",
        'videoBitRate': 564790,
        'videoFrameRate': 29.97,
        'videoFrameRateMode': "CFR",
        'audioCodec': "aac",
        'audioFormat': "AAC",
        'audioBitRate': 127999,
        'audioSampleRate': 48000,
        'timelineStatus': "ready",
        'timelineError':
            "The requested file is not a valid video or audio file (ffprobe: Invalid data found when processing input)",
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

      final response = await videos.get(
        videoId: "<VIDEO_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/%3CVIDEO_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<models.Video>());
    });

    test('test method update()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        '\$permissions': [],
        'bucketId': "5e5ea5c16897e",
        'fileId': "d5fg5ehg1c168g7c",
        'name': "Product demo",
        'size': 23647142,
        'format': "MPEG-4",
        'duration': 92810,
        'width': 960,
        'height': 544,
        'aspectRatio': "16:9",
        'videoCodec': "h264",
        'videoFormat': "AVC",
        'videoFormatProfile': "Baseline@L3.1",
        'videoBitRate': 564790,
        'videoFrameRate': 29.97,
        'videoFrameRateMode': "CFR",
        'audioCodec': "aac",
        'audioFormat': "AAC",
        'audioBitRate': 127999,
        'audioSampleRate': 48000,
        'timelineStatus': "ready",
        'timelineError':
            "The requested file is not a valid video or audio file (ffprobe: Invalid data found when processing input)",
      };

      when(
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await videos.update(
        videoId: "<VIDEO_ID>",
        name: "<NAME>",
        permissions: [],
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/videos/%3CVIDEO_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "name": "<NAME>",
        "permissions": isA<List>(),
      });
      expect(response, isA<models.Video>());
    });

    test('test method delete()', () async {
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

      final response = await videos.delete(
        videoId: "<VIDEO_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/videos/%3CVIDEO_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
    });

    test('test method listCaptions()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'captions': [],
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

      final response = await videos.listCaptions(
        videoId: "<VIDEO_ID>",
        queries: [],
        total: false,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/%3CVIDEO_ID%3E/captions",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "queries": isA<List>(),
        "total": false,
      });
      expect(response, isA<models.VideoCaptionList>());
    });

    test('test method createCaption()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'videoId': "5e5ea5c16897e",
        'bucketId': "d5fg5ehg1c168g7c",
        'fileId': "c5fg5emg1c168grr",
        'name': "English",
        'language': "eng",
        'default': true,
        'embedded': true,
        'targetDuration': 93,
        'status': "ready",
        'error':
            "Caption is not a proper .srt file (Invalid timestamp delimiter at line 2)",
        'size': 4096,
      };

      when(
        client.call(
          HttpMethod.post,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await videos.createCaption(
        videoId: "<VIDEO_ID>",
        bucketId: "<BUCKET_ID>",
        fileId: "<FILE_ID>",
        name: "<NAME>",
        language: "aar",
        xdefault: false,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.post,
          path: "/videos/%3CVIDEO_ID%3E/captions",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "bucketId": "<BUCKET_ID>",
        "fileId": "<FILE_ID>",
        "name": "<NAME>",
        "language": "aar",
        "default": false,
      });
      expect(response, isA<models.VideoCaption>());
    });

    test('test method updateCaption()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'videoId': "5e5ea5c16897e",
        'bucketId': "d5fg5ehg1c168g7c",
        'fileId': "c5fg5emg1c168grr",
        'name': "English",
        'language': "eng",
        'default': true,
        'embedded': true,
        'targetDuration': 93,
        'status': "ready",
        'error':
            "Caption is not a proper .srt file (Invalid timestamp delimiter at line 2)",
        'size': 4096,
      };

      when(
        client.call(
          HttpMethod.patch,
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          params: anyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).thenAnswer((_) async => Response(data: data));

      final response = await videos.updateCaption(
        videoId: "<VIDEO_ID>",
        captionId: "<CAPTION_ID>",
        bucketId: "<BUCKET_ID>",
        fileId: "<FILE_ID>",
        name: "<NAME>",
        language: "aar",
        xdefault: false,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.patch,
          path: "/videos/%3CVIDEO_ID%3E/captions/%3CCAPTION_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "bucketId": "<BUCKET_ID>",
        "fileId": "<FILE_ID>",
        "name": "<NAME>",
        "language": "aar",
        "default": false,
      });
      expect(response, isA<models.VideoCaption>());
    });

    test('test method deleteCaption()', () async {
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

      final response = await videos.deleteCaption(
        videoId: "<VIDEO_ID>",
        captionId: "<CAPTION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/videos/%3CVIDEO_ID%3E/captions/%3CCAPTION_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
    });

    test('test method getCmafHlsManifest()', () async {
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

      final response = await videos.getCmafHlsManifest(
        videoId: "<VIDEO_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/%3CVIDEO_ID%3E/outputs/cmaf/master.m3u8",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<Uint8List>());
    });

    test('test method getCmafDashManifest()', () async {
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

      final response = await videos.getCmafDashManifest(
        videoId: "<VIDEO_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/%3CVIDEO_ID%3E/outputs/cmaf/master.mpd",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<Uint8List>());
    });

    test('test method getDashManifest()', () async {
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

      final response = await videos.getDashManifest(
        videoId: "<VIDEO_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/%3CVIDEO_ID%3E/outputs/dash/master.mpd",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<Uint8List>());
    });

    test('test method getHlsManifest()', () async {
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

      final response = await videos.getHlsManifest(
        videoId: "<VIDEO_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/%3CVIDEO_ID%3E/outputs/hls/master.m3u8",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<Uint8List>());
    });

    test('test method getCaptionManifest()', () async {
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

      final response = await videos.getCaptionManifest(
        videoId: "<VIDEO_ID>",
        output: enums.VideoOutput.hls,
        captionId: "<CAPTION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/%3CVIDEO_ID%3E/outputs/hls/captions/%3CCAPTION_ID%3E/manifest",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<Uint8List>());
    });

    test('test method listRenditions()', () async {
      final Map<String, dynamic> data = {
        'total': 5,
        'renditions': [],
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

      final response = await videos.listRenditions(
        videoId: "<VIDEO_ID>",
        queries: [],
        total: false,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/%3CVIDEO_ID%3E/renditions",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "queries": isA<List>(),
        "total": false,
      });
      expect(response, isA<models.VideoRenditionList>());
    });

    test('test method getRendition()', () async {
      final Map<String, dynamic> data = {
        '\$id': "5e5ea5c16897e",
        '\$createdAt': "2020-10-15T06:38:00.000+00:00",
        '\$updatedAt': "2020-10-15T06:38:00.000+00:00",
        'videoId': "5e5ea5c16897e",
        'profileId': "d5fg5ehg1c168g7c",
        'name': "1280X720@3679",
        'startedAt': "2020-10-15T06:38:00.000+00:00",
        'endedAt': "2020-10-15T06:38:00.000+00:00",
        'width': 1280,
        'height': 720,
        'videoBitRate': 3551000,
        'audioBitRate': 128000,
        'targetDuration': 6.006,
        'status': "ready",
        'error':
            "The requested file is not a valid video or audio file (ffprobe: Invalid data found when processing input)",
        'progress': 88,
        'output': "hls",
        'codec': "h264",
        'size': 18350080,
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

      final response = await videos.getRendition(
        videoId: "<VIDEO_ID>",
        renditionId: "<RENDITION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/%3CVIDEO_ID%3E/renditions/%3CRENDITION_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<models.VideoRendition>());
    });

    test('test method deleteRendition()', () async {
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

      final response = await videos.deleteRendition(
        videoId: "<VIDEO_ID>",
        renditionId: "<RENDITION_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.delete,
          path: "/videos/%3CVIDEO_ID%3E/renditions/%3CRENDITION_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
    });

    test('test method getThumbnail()', () async {
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

      final response = await videos.getThumbnail(
        videoId: "<VIDEO_ID>",
        thumbnailId: "<THUMBNAIL_ID>",
        width: 1,
        height: 1,
        output: enums.ImageFormat.jpg,
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/%3CVIDEO_ID%3E/thumbnails/%3CTHUMBNAIL_ID%3E",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, {
        "width": 1,
        "height": 1,
        "output": enums.ImageFormat.jpg.value,
      });
      expect(response, isA<Uint8List>());
    });

    test('test method getTimeline()', () async {
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

      final response = await videos.getTimeline(
        videoId: "<VIDEO_ID>",
      );
      final Map<String, dynamic> params = verify(
        client.call(
          HttpMethod.get,
          path: "/videos/%3CVIDEO_ID%3E/timeline",
          headers: anyNamed('headers'),
          params: captureAnyNamed('params'),
          responseType: anyNamed('responseType'),
        ),
      ).captured.single;
      expect(params, isEmpty);
      expect(response, isA<Uint8List>());
    });
  });
}
