part of appwrite.models;

/// Files List
class FileList {
    /// Total number of items available on the server.
    final int sum;
    /// List of files.
    final List<File> files;

    FileList({
        required this.sum,
        required this.files,
    });

    factory FileList.fromMap(Map<String, dynamic> map) {
        return FileList(
            sum: map['sum'],
            files: List<File>.from(map['files'].map((p) => File.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "files": files.map((p) => p.toMap()),
        };
    }
}
