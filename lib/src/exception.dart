class AppwriteException implements Exception {
  final String? message;
  final int? code;
  final String? type;
  final dynamic response;

  AppwriteException([this.message = "", this.code, this.type, this.response]);

  @override
  String toString() {
    if (message == null) return "AppwriteException";
    return "AppwriteException: $type, $message (${code ?? 0})";
  }
}
