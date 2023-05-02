import 'call_handlers/call_handler.dart';
import 'call_params.dart';
import 'client.dart';
import 'response.dart';

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

  Future<Response> call(CallParams params);

  Future<ClientBase> setOfflinePersistency({
    bool status = true,
    void Function(Object)? onWriteQueueError,
  });

  bool getOfflinePersistency();

  ClientBase setOfflineCacheSize(int kbytes);

  int getOfflineCacheSize();

  ClientBase addHandler(CallHandler handler);
}
