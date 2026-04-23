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
  @override
  ClientBase setLocale(value);
  /// The user session to authenticate with
  @override
  ClientBase setSession(value);
  /// Your secret dev API key
  @override
  ClientBase setDevKey(value);
  /// Impersonate a user by ID on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data.
  @override
  ClientBase setImpersonateUserId(value);
  /// Impersonate a user by email on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data.
  @override
  ClientBase setImpersonateUserEmail(value);
  /// Impersonate a user by phone on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data.
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
