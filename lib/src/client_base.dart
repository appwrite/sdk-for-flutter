import 'response.dart';
import 'client.dart';
import 'enums.dart';

abstract class ClientBase implements Client {
  /// Your secret JSON Web Token
  @override
  ClientBase setJWT(value);

  @override
  ClientBase setLocale(value);

  @override
  Client setEndPointRealtime(String endPoint);

  @override
  ClientBase addHeader(String key, String value);

  @override
  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  });
}
