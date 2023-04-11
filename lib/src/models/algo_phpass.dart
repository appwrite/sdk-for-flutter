part of appwrite.models;

/// AlgoPHPass
class AlgoPhpass implements Model {
    /// Algo type.
    final String type;

    AlgoPhpass({
        required this.type,
    });

    factory AlgoPhpass.fromMap(Map<String, dynamic> map) {
        return AlgoPhpass(
            type: map['type'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "type": type,
        };
    }
}
