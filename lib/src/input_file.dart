import 'package:http/http.dart' show MultipartFile;

class InputFile {
  final MultipartFile? file;
  final String? path;
  final String? fileName;

  InputFile({this.file, this.path, this.fileName});
}
