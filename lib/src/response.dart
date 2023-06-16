import 'dart:convert';

class Response<T> {
  Response({this.headers = const {}, this.data});

  final Map<String, String> headers;
  T? data;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
