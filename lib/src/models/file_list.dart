part of '../../models.dart';

/// Files List
class FileList implements Model {
  /// Total number of files documents that matched your query.
  final int total;

  /// List of files.
  final List<File> files;

  FileList({
    required this.total,
    required this.files,
  });

  factory FileList.fromMap(Map<String, dynamic> map) {
    return FileList(
      total: map['total'],
      files: List<File>.from(map['files'].map((p) => File.fromMap(p))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "files": files.map((p) => p.toMap()).toList(),
    };
  }
}
