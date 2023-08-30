part of appwrite.models;

/// Branch
class Branch implements Model {
    /// Branch Name.
    final String name;

    Branch({
        required this.name,
    });

    factory Branch.fromMap(Map<String, dynamic> map) {
        return Branch(
            name: map['name'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "name": name,
        };
    }
}
