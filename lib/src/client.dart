import 'enums.dart';
import 'client_stub.dart'
    if (dart.library.js_interop) 'client_browser.dart'
    if (dart.library.io) 'client_io.dart';
import 'response.dart';
import 'upload_progress.dart';

/// [Client] that handles requests to Appwrite.
///
/// The [Client] is also responsible for managing user's sessions.
abstract class Client {
  /// The size for cunked uploads in bytes.
  static const int CHUNK_SIZE = 5 * 1024 * 1024;

  /// Holds configuration such as project.
  late Map<String, String> config;
  late String _endPoint;
  late String? _endPointRealtime;

  /// Appwrite endpoint.
  String get endPoint => _endPoint;

  /// Appwrite realtime endpoint.
  String? get endPointRealtime => _endPointRealtime;

  /// Initializes a [Client].
  factory Client({
    String endPoint = 'https://cloud.appwrite.io/v1',
    bool selfSigned = false,
  }) => createClient(endPoint: endPoint, selfSigned: selfSigned);

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

  /// Set self signed to [status].
  ///
  /// If self signed is true, [Client] will ignore invalid certificates.
  /// This is helpful in environments where your Appwrite
  /// instance does not have a valid SSL certificate.
  Client setSelfSigned({bool status = true});

  /// Set the Appwrite endpoint.
  Client setEndpoint(String endPoint);

  /// Set the Appwrite realtime endpoint.
  Client setEndPointRealtime(String endPoint);

  /// Set Project.
  ///
  /// Your project ID.
  Client setProject(value);

  /// Set JWT.
  ///
  /// Your secret JSON Web Token.
  Client setJWT(value);

  /// Set Locale.
  Client setLocale(value);

  /// Set Session.
  ///
  /// The user session to authenticate with.
  Client setSession(value);

  /// Set DevKey.
  ///
  /// Your secret dev API key.
  Client setDevKey(value);

  /// Add headers that should be sent with all API calls.
  Client addHeader(String key, String value);

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
