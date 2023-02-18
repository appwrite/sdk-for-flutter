import 'client.dart';
import 'enums.dart';
import 'response.dart';

abstract class ClientBase implements Client {
  /// Your project ID
  @override
  ClientBase setProject(value);

  /// Your secret JSON Web Token
  @override
  ClientBase setJWT(value);

  @override
  ClientBase setLocale(value);

  @override
  ClientBase setSelfSigned({bool status = true});

  @override
  ClientBase setEndpoint(String endPoint);

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
    String cacheModel = '',
    String cacheKey = '',
    String cacheResponseIdKey = '',
    String cacheResponseContainerKey = '',
    Map<String, Object?>? previous,
  });

  @override
  Future<ClientBase> setOfflinePersistency({
    bool status = true,
    void Function(Object)? onWriteQueueError,
  });

  @override
  bool getOfflinePersistency();

  @override
  ClientBase setOfflineCacheSize(int kbytes);

  @override
  int getOfflineCacheSize();
}
