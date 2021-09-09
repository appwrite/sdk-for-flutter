part of appwrite.models;

class FileList {
    late final int sum;
    late final List<File> files;

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
