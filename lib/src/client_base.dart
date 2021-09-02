import 'response.dart';
import 'client.dart';
import 'enums.dart';

abstract class ClientBase implements Client {  
    /// Your project ID
  ClientBase setProject(value);
    /// Your secret JSON Web Token
  ClientBase setJWT(value);
  ClientBase setLocale(value);

  ClientBase setSelfSigned({bool status = true});

  ClientBase setEndpoint(String endPoint);

  Client setEndPointRealtime(String endPoint);

  ClientBase addHeader(String key, String value);

  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  });
}
