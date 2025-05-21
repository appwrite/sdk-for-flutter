/// HTTP methods.
enum HttpMethod { get, post, put, delete, patch }

extension HttpMethodString on HttpMethod {
  /// Returns the HTTP method in all caps.
  String name() {
    return toString().split('.').last.toUpperCase();
  }
}

enum ResponseType {
  /// Transform the response data to JSON object only when the
  /// content-type of response is "application/json" .
  json,

  /// Transform the response data to a String encoded with UTF8.
  plain,

  /// Get original bytes, the type of response will be List<int>
  bytes
}
