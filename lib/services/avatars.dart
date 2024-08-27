part of '../appwrite.dart';

/// The Avatars service aims to help you complete everyday tasks related to
/// your app image, icons, and avatars.
class Avatars extends Service {
  /// Initializes a [Avatars] service
  Avatars(super.client);

  /// Get browser icon
  ///
  /// You can use this endpoint to show different browser icons to your users.
  /// The code argument receives the browser code as it appears in your user [GET
  /// /account/sessions](https://appwrite.io/docs/references/cloud/client-web/account#getSessions)
  /// endpoint. Use width, height and quality arguments to change the output
  /// settings.
  ///
  /// When one dimension is specified and the other is 0, the image is scaled
  /// with preserved aspect ratio. If both dimensions are 0, the API provides an
  /// image at source quality. If dimensions are not specified, the default size
  /// of image returned is 100x100px.
  Future<Uint8List> getBrowser(
      {required enums.Browser code,
      int? width,
      int? height,
      int? quality}) async {
    final String apiPath =
        '/avatars/browsers/{code}'.replaceAll('{code}', code.value);

    final Map<String, dynamic> params = {
      'width': width,
      'height': height,
      'quality': quality,
      'project': client.config['project'],
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: params, responseType: ResponseType.bytes);
    return res.data;
  }

  /// Get credit card icon
  ///
  /// The credit card endpoint will return you the icon of the credit card
  /// provider you need. Use width, height and quality arguments to change the
  /// output settings.
  ///
  /// When one dimension is specified and the other is 0, the image is scaled
  /// with preserved aspect ratio. If both dimensions are 0, the API provides an
  /// image at source quality. If dimensions are not specified, the default size
  /// of image returned is 100x100px.
  ///
  Future<Uint8List> getCreditCard(
      {required enums.CreditCard code,
      int? width,
      int? height,
      int? quality}) async {
    final String apiPath =
        '/avatars/credit-cards/{code}'.replaceAll('{code}', code.value);

    final Map<String, dynamic> params = {
      'width': width,
      'height': height,
      'quality': quality,
      'project': client.config['project'],
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: params, responseType: ResponseType.bytes);
    return res.data;
  }

  /// Get favicon
  ///
  /// Use this endpoint to fetch the favorite icon (AKA favicon) of any remote
  /// website URL.
  ///
  /// This endpoint does not follow HTTP redirects.
  Future<Uint8List> getFavicon({required String url}) async {
    const String apiPath = '/avatars/favicon';

    final Map<String, dynamic> params = {
      'url': url,
      'project': client.config['project'],
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: params, responseType: ResponseType.bytes);
    return res.data;
  }

  /// Get country flag
  ///
  /// You can use this endpoint to show different country flags icons to your
  /// users. The code argument receives the 2 letter country code. Use width,
  /// height and quality arguments to change the output settings. Country codes
  /// follow the [ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1) standard.
  ///
  /// When one dimension is specified and the other is 0, the image is scaled
  /// with preserved aspect ratio. If both dimensions are 0, the API provides an
  /// image at source quality. If dimensions are not specified, the default size
  /// of image returned is 100x100px.
  ///
  Future<Uint8List> getFlag(
      {required enums.Flag code, int? width, int? height, int? quality}) async {
    final String apiPath =
        '/avatars/flags/{code}'.replaceAll('{code}', code.value);

    final Map<String, dynamic> params = {
      'width': width,
      'height': height,
      'quality': quality,
      'project': client.config['project'],
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: params, responseType: ResponseType.bytes);
    return res.data;
  }

  /// Get image from URL
  ///
  /// Use this endpoint to fetch a remote image URL and crop it to any image size
  /// you want. This endpoint is very useful if you need to crop and display
  /// remote images in your app or in case you want to make sure a 3rd party
  /// image is properly served using a TLS protocol.
  ///
  /// When one dimension is specified and the other is 0, the image is scaled
  /// with preserved aspect ratio. If both dimensions are 0, the API provides an
  /// image at source quality. If dimensions are not specified, the default size
  /// of image returned is 400x400px.
  ///
  /// This endpoint does not follow HTTP redirects.
  Future<Uint8List> getImage(
      {required String url, int? width, int? height}) async {
    const String apiPath = '/avatars/image';

    final Map<String, dynamic> params = {
      'url': url,
      'width': width,
      'height': height,
      'project': client.config['project'],
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: params, responseType: ResponseType.bytes);
    return res.data;
  }

  /// Get user initials
  ///
  /// Use this endpoint to show your user initials avatar icon on your website or
  /// app. By default, this route will try to print your logged-in user name or
  /// email initials. You can also overwrite the user name if you pass the 'name'
  /// parameter. If no name is given and no user is logged, an empty avatar will
  /// be returned.
  ///
  /// You can use the color and background params to change the avatar colors. By
  /// default, a random theme will be selected. The random theme will persist for
  /// the user's initials when reloading the same theme will always return for
  /// the same initials.
  ///
  /// When one dimension is specified and the other is 0, the image is scaled
  /// with preserved aspect ratio. If both dimensions are 0, the API provides an
  /// image at source quality. If dimensions are not specified, the default size
  /// of image returned is 100x100px.
  ///
  Future<Uint8List> getInitials(
      {String? name, int? width, int? height, String? background}) async {
    const String apiPath = '/avatars/initials';

    final Map<String, dynamic> params = {
      'name': name,
      'width': width,
      'height': height,
      'background': background,
      'project': client.config['project'],
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: params, responseType: ResponseType.bytes);
    return res.data;
  }

  /// Get QR code
  ///
  /// Converts a given plain text to a QR code image. You can use the query
  /// parameters to change the size and style of the resulting image.
  ///
  Future<Uint8List> getQR(
      {required String text, int? size, int? margin, bool? download}) async {
    const String apiPath = '/avatars/qr';

    final Map<String, dynamic> params = {
      'text': text,
      'size': size,
      'margin': margin,
      'download': download,
      'project': client.config['project'],
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: params, responseType: ResponseType.bytes);
    return res.data;
  }
}
