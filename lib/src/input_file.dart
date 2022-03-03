import 'package:http/http.dart' show MultipartFile;

class InputFile {
  final MultipartFile? file;
  final String? path;
  final String? filename;

  InputFile({this.file, this.path, this.filename});
}
