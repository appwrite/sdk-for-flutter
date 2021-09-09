part of appwrite.models;

class DocumentList {
    late final int sum;
    late final List<Document> documents;

    DocumentList({
        required this.sum,
        required this.documents,
    });

    factory DocumentList.fromMap(Map<String, dynamic> map) {
        return DocumentList(
            sum: map['sum'],
            documents: List<Document>.from(map['documents'].map((p) => Document.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "documents": documents.map((p) => p.toMap()),
        };
    }

    List<T> convertTo<T>(T Function(Map) fromJson) =>
      documents.map((d) => d.convertTo<T>(fromJson)).toList();
}
