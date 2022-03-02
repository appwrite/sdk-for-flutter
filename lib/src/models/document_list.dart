part of appwrite.models;

/// Documents List
class DocumentList implements Model {
    /// Total number of documents documents that matched your query.
    final int total;
    /// List of documents.
    final List<Document> documents;

    DocumentList({
        required this.total,
        required this.documents,
    });

    factory DocumentList.fromMap(Map<String, dynamic> map) {
        return DocumentList(
            total: map['total'],
            documents: List<Document>.from(map['documents'].map((p) => Document.fromMap(p))),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "documents": documents.map((p) => p.toMap()),
        };
    }

    List<T> convertTo<T>(T Function(Map) fromJson) =>
        documents.map((d) => d.convertTo<T>(fromJson)).toList();
}
