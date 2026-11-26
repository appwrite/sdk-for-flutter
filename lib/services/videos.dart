part of '../appwrite.dart';

/// The Videos service allows you to transcode video files into adaptive HLS
/// and DASH streams.
class Videos extends Service {
  /// Initializes a [Videos] service
  Videos(super.client);

  /// Get a list of videos in the current project. Sessions receive only videos
  /// they can read according to each video's `$permissions`. API keys and admins
  /// receive the full project catalog. Playback uses the same document read ACL
  /// plus the `videos.play` (or `videos.read`) scope: a guest can stream a video
  /// that grants `read("any")` or `read("guests")` even though guests lack
  /// `videos.read` and will not see it in this list.
  Future<models.VideoList> list({
    List<String>? queries,
    bool? total,
  }) async {
    final String apiPath = '/videos';

    final Map<String, dynamic> apiParams = {
      if (queries != null) 'queries': queries,
      if (total != null) 'total': total,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.VideoList.fromMap(res.data);
  }

  /// Create a video resource from an existing file in a storage bucket. The
  /// source file must be a video or audio file, and the caller must be able to
  /// read that file. Creating a video stores the document and queues timeline
  /// generation. The worker downloads the source, probes metadata, extracts
  /// embedded captions once, and deletes its working copy when finished. Sources
  /// with a video track also get a thumbnail timeline. Call create-rendition to
  /// package a streaming output.
  ///
  /// An optional `name` defaults to the source file name. An optional
  /// `permissions` array sets the video document ACL (list, get, update, delete,
  /// manage child resources, and playback). By default, only the current user is
  /// granted all permissions; API keys and admins create with empty permissions
  /// when omitted. Guests with `videos.play` can stream when the video grants
  /// them read (`read("any")` or `read("guests")`).
  ///
  /// Uploaded caption files stay listed alongside auto-extracted tracks for the
  /// same language; when the current default is an auto-extracted track with
  /// that code, the upload takes the default flag.
  Future<models.Video> create({
    required String videoId,
    required String bucketId,
    required String fileId,
    String? name,
    List<String>? permissions,
  }) async {
    final String apiPath = '/videos';

    final Map<String, dynamic> apiParams = {
      'videoId': videoId,
      'bucketId': bucketId,
      'fileId': fileId,
      if (name != null) 'name': name,
      if (permissions != null) 'permissions': permissions,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Video.fromMap(res.data);
  }

  /// Get a list of video encode codecs enabled on this instance. Each codec
  /// includes the output formats it may be packaged into.
  Future<models.VideoCodecList> listCodecs() async {
    final String apiPath = '/videos/codecs';

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.VideoCodecList.fromMap(res.data);
  }

  /// Get a video by its unique ID. This endpoint response returns a JSON object
  /// with the video metadata.
  Future<models.Video> get({
    required String videoId,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    final String apiPath = '/videos/{videoId}'.replaceAll(
      '{videoId}',
      _encodePath(videoId),
    );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Video.fromMap(res.data);
  }

  /// Update a video's name, permissions, or both. Only the fields you pass are
  /// changed: omit `name` to keep the current name and `permissions` to keep the
  /// current ACL. The caller must hold update permission on the video document.
  /// The source file cannot be replaced; delete the video and create a new one
  /// to point at a different file.
  Future<models.Video> update({
    required String videoId,
    String? name,
    List<String>? permissions,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    final String apiPath = '/videos/{videoId}'.replaceAll(
      '{videoId}',
      _encodePath(videoId),
    );

    final Map<String, dynamic> apiParams = {
      if (name != null) 'name': name,
      if (permissions != null) 'permissions': permissions,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.patch,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.Video.fromMap(res.data);
  }

  /// Delete a video by its unique ID. This also removes every rendition,
  /// caption, preview and transcoded artifact derived from it. Fails with
  /// `video_rendition_in_progress` while a rendition is started or ended, unless
  /// that rendition has not been updated within the rendition retention window.
  /// Fails with `video_timeline_in_progress` while the video's timeline is being
  /// generated, unless the video has not been updated within the same window.
  Future delete({
    required String videoId,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    final String apiPath = '/videos/{videoId}'.replaceAll(
      '{videoId}',
      _encodePath(videoId),
    );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.delete,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }

  /// Get a list of all the caption tracks attached to a video. You can use the
  /// query params to filter your results.
  Future<models.VideoCaptionList> listCaptions({
    required String videoId,
    List<String>? queries,
    bool? total,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    final String apiPath = '/videos/{videoId}/captions'.replaceAll(
      '{videoId}',
      _encodePath(videoId),
    );

    final Map<String, dynamic> apiParams = {
      if (queries != null) 'queries': queries,
      if (total != null) 'total': total,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.VideoCaptionList.fromMap(res.data);
  }

  /// Add a caption track to a video from a WebVTT or SubRip file in a storage
  /// bucket. The file is normalised to WebVTT and segmented in the background.
  /// Subscribe to `videos.[videoId].captions.[captionId].update` for `started`,
  /// `ready`, and `error` status changes instead of only polling the caption
  /// document.
  ///
  /// Uploaded tracks are listed alongside auto-extracted embedded tracks
  /// (`embedded: true`). When the current default is an auto-extracted track for
  /// the same language code, the upload takes the default flag so players pick
  /// the authored file first. Auto-extracted tracks are never removed
  /// automatically — delete a track explicitly to remove it. Extraction runs
  /// once per video, so a deleted extracted track is not re-created.
  Future<models.VideoCaption> createCaption({
    required String videoId,
    required String bucketId,
    required String fileId,
    required String name,
    required String language,
    bool? xdefault,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    final String apiPath = '/videos/{videoId}/captions'.replaceAll(
      '{videoId}',
      _encodePath(videoId),
    );

    final Map<String, dynamic> apiParams = {
      'bucketId': bucketId,
      'fileId': fileId,
      'name': name,
      'language': language,
      if (xdefault != null) 'default': xdefault,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.post,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.VideoCaption.fromMap(res.data);
  }

  /// Update a caption track by its unique ID. Pass only `name`, `language`,
  /// and/or `default` to retag an extracted track (for example `und` → `heb`
  /// for Hebrew) without replacing the file. Changing `bucketId`/`fileId`
  /// re-packages the track in the background.
  Future<models.VideoCaption> updateCaption({
    required String videoId,
    required String captionId,
    String? bucketId,
    String? fileId,
    String? name,
    String? language,
    bool? xdefault,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    if (captionId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "captionId"',
      );
    }

    final String apiPath = '/videos/{videoId}/captions/{captionId}'
        .replaceAll(
          '{videoId}',
          _encodePath(videoId),
        )
        .replaceAll(
          '{captionId}',
          _encodePath(captionId),
        );

    final Map<String, dynamic> apiParams = {
      if (bucketId != null) 'bucketId': bucketId,
      if (fileId != null) 'fileId': fileId,
      if (name != null) 'name': name,
      if (language != null) 'language': language,
      if (xdefault != null) 'default': xdefault,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.patch,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.VideoCaption.fromMap(res.data);
  }

  /// Delete a caption track by its unique ID, along with its packaged segments.
  Future deleteCaption({
    required String videoId,
    required String captionId,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    if (captionId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "captionId"',
      );
    }

    final String apiPath = '/videos/{videoId}/captions/{captionId}'
        .replaceAll(
          '{videoId}',
          _encodePath(videoId),
        )
        .replaceAll(
          '{captionId}',
          _encodePath(captionId),
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.delete,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }

  /// Get the top-level streaming manifest for a video output: an HLS master
  /// playlist (`master.m3u8`) or a DASH MPD (`master.mpd`). Hand this URL to a
  /// player to begin adaptive playback.
  ///
  /// Guests can request this URL when they hold `videos.play` (or `videos.read`)
  /// **and** the video document grants them read. A video with `read("any")` or
  /// `read("guests")` is playable without a session.
  ///
  /// For CMAF renditions, use `getCmafHlsManifest` or `getCmafDashManifest`.
  /// Both masters point at the same fMP4 segment set.
  Future<Uint8List> getCmafHlsManifest({
    required String videoId,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    final String apiPath = '/videos/{videoId}/outputs/cmaf/master.m3u8'
        .replaceAll(
          '{videoId}',
          _encodePath(videoId),
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': '*/*',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
      responseType: ResponseType.bytes,
    );
    return res.data;
  }

  /// Get the top-level streaming manifest for a video output: an HLS master
  /// playlist (`master.m3u8`) or a DASH MPD (`master.mpd`). Hand this URL to a
  /// player to begin adaptive playback.
  ///
  /// Guests can request this URL when they hold `videos.play` (or `videos.read`)
  /// **and** the video document grants them read. A video with `read("any")` or
  /// `read("guests")` is playable without a session.
  ///
  /// For CMAF renditions, use `getCmafHlsManifest` or `getCmafDashManifest`.
  /// Both masters point at the same fMP4 segment set.
  Future<Uint8List> getCmafDashManifest({
    required String videoId,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    final String apiPath = '/videos/{videoId}/outputs/cmaf/master.mpd'
        .replaceAll(
          '{videoId}',
          _encodePath(videoId),
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': '*/*',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
      responseType: ResponseType.bytes,
    );
    return res.data;
  }

  /// Get the top-level streaming manifest for a video output: an HLS master
  /// playlist (`master.m3u8`) or a DASH MPD (`master.mpd`). Hand this URL to a
  /// player to begin adaptive playback.
  ///
  /// Guests can request this URL when they hold `videos.play` (or `videos.read`)
  /// **and** the video document grants them read. A video with `read("any")` or
  /// `read("guests")` is playable without a session.
  ///
  /// For CMAF renditions, use `getCmafHlsManifest` or `getCmafDashManifest`.
  /// Both masters point at the same fMP4 segment set.
  Future<Uint8List> getDashManifest({
    required String videoId,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    final String apiPath = '/videos/{videoId}/outputs/dash/master.mpd'
        .replaceAll(
          '{videoId}',
          _encodePath(videoId),
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': '*/*',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
      responseType: ResponseType.bytes,
    );
    return res.data;
  }

  /// Get the top-level streaming manifest for a video output: an HLS master
  /// playlist (`master.m3u8`) or a DASH MPD (`master.mpd`). Hand this URL to a
  /// player to begin adaptive playback.
  ///
  /// Guests can request this URL when they hold `videos.play` (or `videos.read`)
  /// **and** the video document grants them read. A video with `read("any")` or
  /// `read("guests")` is playable without a session.
  ///
  /// For CMAF renditions, use `getCmafHlsManifest` or `getCmafDashManifest`.
  /// Both masters point at the same fMP4 segment set.
  Future<Uint8List> getHlsManifest({
    required String videoId,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    final String apiPath = '/videos/{videoId}/outputs/hls/master.m3u8'
        .replaceAll(
          '{videoId}',
          _encodePath(videoId),
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': '*/*',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
      responseType: ResponseType.bytes,
    );
    return res.data;
  }

  /// Get the playable caption resource for a video output: an HLS captions
  /// playlist, or the WebVTT file itself for DASH.
  ///
  /// Guests can request this URL when they hold `videos.play` (or `videos.read`)
  /// **and** the video document grants them read.
  Future<Uint8List> getCaptionManifest({
    required String videoId,
    required enums.VideoOutput output,
    required String captionId,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    if (captionId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "captionId"',
      );
    }

    final String apiPath =
        '/videos/{videoId}/outputs/{output}/captions/{captionId}/manifest'
            .replaceAll(
              '{videoId}',
              _encodePath(videoId),
            )
            .replaceAll(
              '{output}',
              _encodePath(output.value),
            )
            .replaceAll(
              '{captionId}',
              _encodePath(captionId),
            );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': '*/*',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
      responseType: ResponseType.bytes,
    );
    return res.data;
  }

  /// Get a list of all the renditions of a video. You can use the query params
  /// to filter your results.
  Future<models.VideoRenditionList> listRenditions({
    required String videoId,
    List<String>? queries,
    bool? total,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    final String apiPath = '/videos/{videoId}/renditions'.replaceAll(
      '{videoId}',
      _encodePath(videoId),
    );

    final Map<String, dynamic> apiParams = {
      if (queries != null) 'queries': queries,
      if (total != null) 'total': total,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.VideoRenditionList.fromMap(res.data);
  }

  /// Get a rendition by its unique ID, including its current transcoding status
  /// and progress.
  Future<models.VideoRendition> getRendition({
    required String videoId,
    required String renditionId,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    if (renditionId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "renditionId"',
      );
    }

    final String apiPath = '/videos/{videoId}/renditions/{renditionId}'
        .replaceAll(
          '{videoId}',
          _encodePath(videoId),
        )
        .replaceAll(
          '{renditionId}',
          _encodePath(renditionId),
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return models.VideoRendition.fromMap(res.data);
  }

  /// Delete a rendition by its unique ID, along with its packaged segments and
  /// transcoded output. Fails with `video_rendition_in_progress` while the
  /// rendition is started or ended, unless it has not been updated within the
  /// rendition retention window.
  Future deleteRendition({
    required String videoId,
    required String renditionId,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    if (renditionId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "renditionId"',
      );
    }

    final String apiPath = '/videos/{videoId}/renditions/{renditionId}'
        .replaceAll(
          '{videoId}',
          _encodePath(videoId),
        )
        .replaceAll(
          '{renditionId}',
          _encodePath(renditionId),
        );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final res = await client.call(
      HttpMethod.delete,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
    );

    return res.data;
  }

  /// Get a single thumbnail sheet from a video's timeline as an image. You can
  /// resize the returned image and choose its output format.
  ///
  /// Guests can request this URL when they hold `videos.play` (or `videos.read`)
  /// **and** the video document grants them read.
  Future<Uint8List> getThumbnail({
    required String videoId,
    required String thumbnailId,
    int? width,
    int? height,
    enums.ImageFormat? output,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    if (thumbnailId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "thumbnailId"',
      );
    }

    final String apiPath = '/videos/{videoId}/thumbnails/{thumbnailId}'
        .replaceAll(
          '{videoId}',
          _encodePath(videoId),
        )
        .replaceAll(
          '{thumbnailId}',
          _encodePath(thumbnailId),
        );

    final Map<String, dynamic> apiParams = {
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (output != null) 'output': output?.value,
    };

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': 'image/*',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
      responseType: ResponseType.bytes,
    );
    return res.data;
  }

  /// Get the WebVTT thumbnail timeline for a video, used to render scrubbing
  /// thumbnails in a player. Timeline generation is queued when the video is
  /// created. Subscribe to `videos.[videoId].timelines.update` for probe and
  /// terminal updates, or poll this endpoint until it returns a WebVTT document.
  /// Audio-only sources produce no timeline and this endpoint returns
  /// `video_timelines_not_found`.
  ///
  /// Guests can request this URL when they hold `videos.play` (or `videos.read`)
  /// **and** the video document grants them read. A video with `read("any")` or
  /// `read("guests")` is playable without a session.
  Future<Uint8List> getTimeline({
    required String videoId,
  }) async {
    if (videoId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "videoId"',
      );
    }

    final String apiPath = '/videos/{videoId}/timeline'.replaceAll(
      '{videoId}',
      _encodePath(videoId),
    );

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'X-Appwrite-Project': client.config['project'] ?? '',
      'accept': '*/*',
    };

    final res = await client.call(
      HttpMethod.get,
      path: apiPath,
      params: apiParams,
      headers: apiHeaders,
      responseType: ResponseType.bytes,
    );
    return res.data;
  }
}
