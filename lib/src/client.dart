import 'enums.dart';
import 'client_stub.dart'
    if (dart.library.js_interop) 'client_browser.dart'
    if (dart.library.io) 'client_io.dart';
import 'exception.dart';
import 'response.dart';
import 'upload_progress.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// [Client] that handles requests to Appwrite.
///
/// The [Client] is also responsible for managing user's sessions.
abstract class ClientAuth {
  /// Holds configuration such as project.
  Map<String, String> get config;

  /// Appwrite endpoint.
  String get endPoint;

  /// Appwrite realtime endpoint.
  String? get endPointRealtime;

  /// Open a realtime WebSocket connection.
  Future<WebSocketChannel> realtimeWebSocket(Uri uri);

  /// Session cookie fallback for browser realtime authentication.
  String? realtimeFallbackCookie();

  /// Handle OAuth2 session creation.
  Future webAuth(Uri url, {String? callbackUrlScheme});

  /// Upload a file in chunks.
  Future<Response> chunkedUpload({
    required String path,
    required Map<String, dynamic> params,
    required String paramName,
    required String idParamName,
    required Map<String, String> headers,
    Function(UploadProgress)? onProgress,
  });

  /// Sends a "ping" request to Appwrite to verify connectivity.
  Future<String> ping();

  /// Send the API request.
  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  });
}

/// Legacy client with mutable setter methods.
abstract class Client implements ClientAuth {
  /// The size for chunked uploads in bytes.
  static const int chunkSize = 5 * 1024 * 1024;

  /// Initializes a [Client].
  factory Client({
    String endPoint = 'https://cloud.appwrite.io/v1',
    bool selfSigned = false,
  }) => createClient(endPoint: endPoint, selfSigned: selfSigned);

  /// Initializes a client with project authentication.
  static ClientAuth from({
    String endPoint = 'https://cloud.appwrite.io/v1',
    required String projectId,
    String? endPointRealtime,
    String? locale,
    bool selfSigned = false,
  }) => _fromClient(
        endPoint: endPoint,
        projectId: projectId,
        endPointRealtime: endPointRealtime,
        locale: locale,
        selfSigned: selfSigned,
      );

  static Client _fromClient({
    required String endPoint,
    required String projectId,
    String? endPointRealtime,
    String? locale,
    required bool selfSigned,
  }) {
    _validateEndpoint(endPoint);
    if (endPointRealtime != null) {
      _validateRealtimeEndpoint(endPointRealtime);
    }

    final client = createClient(endPoint: endPoint, selfSigned: selfSigned);

    _setHeader(
      client,
      'project',
      'X-Appwrite-Project',
      projectId,
    );
    if (endPointRealtime != null) {
      // ignore: deprecated_member_use_from_same_package
      client.setEndPointRealtime(endPointRealtime);
    }
    if (locale != null) {
      _setHeader(
        client,
        'locale',
        'X-Appwrite-Locale',
        locale,
      );
    }

    return client;
  }

  static void _validateEndpoint(String endPoint) {
    if (!endPoint.startsWith('http://') && !endPoint.startsWith('https://')) {
      throw AppwriteException('Invalid endpoint URL: $endPoint');
    }
  }

  static void _validateRealtimeEndpoint(String endPointRealtime) {
    if (!endPointRealtime.startsWith('ws://') && !endPointRealtime.startsWith('wss://')) {
      throw AppwriteException('Invalid realtime endpoint URL: $endPointRealtime');
    }
  }

  static void _setHeader(
    Client client,
    String configKey,
    String header,
    String value,
  ) {
    client.config[configKey] = value;
    if (configKey != configKey.toLowerCase()) {
      client.config[configKey.toLowerCase()] = value;
    }
    client.addHeader(header, value);
  }

  /// Initializes a client with a user session.
  static ClientAuth fromSession({
    String endPoint = 'https://cloud.appwrite.io/v1',
    required String projectId,
    required String session,
    String? endPointRealtime,
    String? locale,
    bool selfSigned = false,
  }) {
    final client = _fromClient(
      endPoint: endPoint,
      projectId: projectId,
      endPointRealtime: endPointRealtime,
      locale: locale,
      selfSigned: selfSigned,
    );

    _setHeader(
      client,
      'session',
      'X-Appwrite-Session',
      session,
    );
    return client;
  }

  /// Initializes a client with a development key.
  static ClientAuth fromDevKey({
    String endPoint = 'https://cloud.appwrite.io/v1',
    required String projectId,
    required String devKey,
    String? endPointRealtime,
    String? locale,
    bool selfSigned = false,
  }) {
    final client = _fromClient(
      endPoint: endPoint,
      projectId: projectId,
      endPointRealtime: endPointRealtime,
      locale: locale,
      selfSigned: selfSigned,
    );

    _setHeader(
      client,
      'devKey',
      'X-Appwrite-Dev-Key',
      devKey,
    );
    return client;
  }

  /// Initializes a client with user impersonation.
  static ClientAuth fromImpersonation({
    String endPoint = 'https://cloud.appwrite.io/v1',
    required String projectId,
    required String session,
    String? userId,
    String? userEmail,
    String? userPhone,
    String? endPointRealtime,
    String? locale,
    bool selfSigned = false,
  }) {
    final targets = [userId, userEmail, userPhone].whereType<String>().length;
    if (targets != 1) {
      throw AppwriteException(
        'Exactly one impersonation target must be provided',
      );
    }

    final client = _fromClient(
      endPoint: endPoint,
      projectId: projectId,
      endPointRealtime: endPointRealtime,
      locale: locale,
      selfSigned: selfSigned,
    );

    _setHeader(
      client,
      'session',
      'X-Appwrite-Session',
      session,
    );

    if (userId != null) {
      _setHeader(
        client,
        'impersonateUserId',
        'X-Appwrite-Impersonate-User-Id',
        userId,
      );
    } else if (userEmail != null) {
      _setHeader(
        client,
        'impersonateUserEmail',
        'X-Appwrite-Impersonate-User-Email',
        userEmail,
      );
    } else if (userPhone != null) {
      _setHeader(
        client,
        'impersonateUserPhone',
        'X-Appwrite-Impersonate-User-Phone',
        userPhone,
      );
    }

    return client;
  }

  /// Set self signed to [status].
  ///
  /// If self signed is true, [Client] will ignore invalid certificates.
  /// This is helpful in environments where your Appwrite
  /// instance does not have a valid SSL certificate.
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setSelfSigned({bool status = true});

  /// Set the Appwrite endpoint.
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setEndpoint(String endPoint);

  /// Set the Appwrite realtime endpoint.
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setEndPointRealtime(String endPoint);

  /// Set Project.
  ///
  /// Your project ID.
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setProject(String value);

  /// Set JWT.
  ///
  /// Your secret JSON Web Token.
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setJWT(String value);

  /// Set Locale.
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setLocale(String value);

  /// Set Session.
  ///
  /// The user session to authenticate with.
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setSession(String value);

  /// Set DevKey.
  ///
  /// Your secret dev API key.
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setDevKey(String value);

  /// Set Cookie.
  ///
  /// The user cookie to authenticate with. Used by SDKs that forward an incoming Cookie header in server-side runtimes..
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setCookie(String value);

  /// Set ImpersonateUserId.
  ///
  /// Impersonate a user by ID on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data..
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setImpersonateUserId(String value);

  /// Set ImpersonateUserEmail.
  ///
  /// Impersonate a user by email on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data..
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setImpersonateUserEmail(String value);

  /// Set ImpersonateUserPhone.
  ///
  /// Impersonate a user by phone on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data..
  @Deprecated('Use Client.from or another factory constructor instead.')
  Client setImpersonateUserPhone(String value);

  /// Add headers that should be sent with all API calls.
  Client addHeader(String key, String value);

  /// Get the current request headers.
  Map<String, String> getHeaders();
}
