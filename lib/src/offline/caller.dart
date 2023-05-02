import '../call_params.dart';
import '../response.dart';

typedef Caller = Future<Response<dynamic>> Function(CallParams params);
