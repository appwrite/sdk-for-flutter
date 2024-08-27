/// Exception thrown by the appwrite package.
class AppwriteException implements Exception {
  /// Error message.
  final String? message;

  /// Error type.
  ///
  /// See [Error Types](https://appwrite.io/docs/response-codes#errorTypes)
  /// for more information.
  final String? type;
  final int? code;
  final dynamic response;

  /// Initializes an Appwrite Exception.
  AppwriteException([this.message = "", this.code, this.type, this.response]);

  /// Returns the error type, message, and code.
  @override
  String toString() {
    if (message == null || message == "") return "AppwriteException";
    return "AppwriteException: ${type ?? ''}, $message (${code ?? 0})";
  }
}
