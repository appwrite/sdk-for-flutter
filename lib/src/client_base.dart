import 'response.dart';
import 'client.dart';
import 'enums.dart';

abstract class ClientBase implements Client {
  /// Your project ID
  @override
  ClientBase setProject(value);

  /// Your secret JSON Web Token
  @override
  ClientBase setJWT(value);

  /// The OAuth access token to authenticate with
  @override
  ClientBase setBearer(value);

  @override
  ClientBase setLocale(value);

  /// The user session to authenticate with
  @override
  ClientBase setSession(value);

  /// Your secret dev API key
  @override
  ClientBase setDevKey(value);

  /// The user cookie to authenticate with. Used by SDKs that forward an incoming Cookie header in server-side runtimes.
  @override
  ClientBase setCookie(value);

  /// Impersonate a user by ID
  @override
  ClientBase setImpersonateUserId(value);

  /// Impersonate a user by email
  @override
  ClientBase setImpersonateUserEmail(value);

  /// Impersonate a user by phone
  @override
  ClientBase setImpersonateUserPhone(value);


  @override
  ClientBase setSelfSigned({bool status = true});

  @override
  ClientBase setEndpoint(String endPoint);

  @override
  Client setEndPointRealtime(String endPoint);

  @override
  ClientBase addHeader(String key, String value);

  @override
  Map<String, String> getHeaders();

  @override
  Future<String> ping() async {
    final String apiPath = '/ping';
    final response = await call(
      HttpMethod.get,
      path: apiPath,
      headers: {
        'X-Appwrite-Project': config['project'] ?? '',
        'accept': 'application/json',
      },
      responseType: ResponseType.plain,
    );
    return response.data;
  }

  @override
  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  });
}
