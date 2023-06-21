import 'dart:convert';

/// Appwrite Response
class Response<T> {
  /// Initializes a [Response]
  Response({this.data});

  /// HTTP body returned from Appwrite
  T? data;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
