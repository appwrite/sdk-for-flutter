part of appwrite.models;

/// Team
class Team implements Model {
    /// Team ID.
    final String $id;
    /// Team name.
    final String name;
    /// Team creation date in Unix timestamp.
    final int dateCreated;
    /// Total sum of team members.
    final int sum;

    Team({
        required this.$id,
        required this.name,
        required this.dateCreated,
        required this.sum,
    });

    factory Team.fromMap(Map<String, dynamic> map) {
        return Team(
            $id: map['\$id'],
            name: map['name'],
            dateCreated: map['dateCreated'],
            sum: map['sum'],
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "name": name,
            "dateCreated": dateCreated,
            "sum": sum,
        };
    }
}
