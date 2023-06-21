part of appwrite.models;

/// Team
class Team implements Model {
    /// Team ID.
    final String $id;
    /// Team name.
    final String name;
    /// Team creation date in Unix timestamp.
    final int dateCreated;
    /// Total number of team members.
    final int total;

    Team({
        required this.$id,
        required this.name,
        required this.dateCreated,
        required this.total,
    });

    factory Team.fromMap(Map<String, dynamic> map) {
        return Team(
            $id: map['\$id'].toString(),
            name: map['name'].toString(),
            dateCreated: map['dateCreated'],
            total: map['total'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "name": name,
            "dateCreated": dateCreated,
            "total": total,
        };
    }
}
