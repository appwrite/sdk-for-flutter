class AppwriteException implements Exception {
  final String? message;
  final int? code;
  final dynamic response;

  AppwriteException([this.message = "", this.code, this.response]);
  
  String toString() {
    if (message == null) return "AppwriteException";
    return "AppwriteException: $message (${code ?? 0})";
  }
}
