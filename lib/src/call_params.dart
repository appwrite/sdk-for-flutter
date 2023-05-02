import 'enums.dart';

class CallParams {
  final HttpMethod method;
  final String path;
  final Map<String, String> headers = {};
  final Map<String, dynamic> params = {};
  final ResponseType? responseType;
  final Map<String, Object?> context = {};

  CallParams(
    this.method,
    this.path, {
    this.responseType,
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    Map<String, Object?> context = const {},
  }) {
    this.headers.addAll(headers);
    this.params.addAll(params);
    this.context.addAll(context);
  }
}
