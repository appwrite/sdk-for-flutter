import '../call_params.dart';
import '../response.dart';

abstract class CallHandler {
  late CallHandler next;

  void setNext(CallHandler next) {
    this.next = next;
  }

  Future<Response> handleCall(CallParams params);
}
