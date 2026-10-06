part of '../appwrite.dart';

class Analytics extends Service {
  /// Initializes a [Analytics] service
  Analytics(super.client);

  /// Send a tracking event from a browser, native app, or server-side SDK.
  Future createEvent({
    required String propertyId,
    required String name,
    required String url,
    String? domain,
    String? referrer,
    int? screenWidth,
    String? sessionHash,
    int? scrollDepth,
    int? engagementTime,
    List<String>? props,
    String? userId,
    String? ip,
    String? userAgent,
  }) async {
    if (propertyId.isEmpty) {
      throw AppwriteException(
        'Missing required parameter: "propertyId"',
      );
    }

    final String apiPath = '/analytics/properties/{propertyId}/events'
        .replaceAll(
          '{propertyId}',
          propertyId,
        );

    final Map<String, dynamic> apiParams = {
      'name': name,
      'url': url,
      if (domain != null) 'domain': domain,
      if (referrer != null) 'referrer': referrer,
      if (screenWidth != null) 'screenWidth': screenWidth,
      if (sessionHash != null) 'sessionHash': sessionHash,
      if (scrollDepth != null) 'scrollDepth': scrollDepth,
      if (engagementTime != null) 'engagementTime': engagementTime,
      if (props != null) 'props': props,
      if (userId != null) 'userId': userId,
      if (ip != null) 'ip': ip,
      if (userAgent != null) 'userAgent': userAgent,
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

    return res.data;
  }
}
