import 'dart:convert';

class Response<T> {
  Response({this.data});

  T? data;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
