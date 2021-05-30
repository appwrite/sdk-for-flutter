part of appwrite;

class AppwriteException implements Exception {
  final String message;
  final int? code;
  final dynamic response;

  AppwriteException([this.message = "", this.code, this.response]);
  
}