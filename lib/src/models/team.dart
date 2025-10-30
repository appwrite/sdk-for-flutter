part of '../../models.dart';

/// Team
class Team implements Model {
    /// Team ID.
    final String $id;

    /// Team creation date in ISO 8601 format.
    final String $createdAt;

    /// Team update date in ISO 8601 format.
    final String $updatedAt;

    /// Team name.
    final String name;

    /// Total number of team members.
    final int total;

    /// Team preferences as a key-value object
    final Preferences prefs;

    Team({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.name,
        required this.total,
        required this.prefs,
    });

    factory Team.fromMap(Map<String, dynamic> map) {
        return Team(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            name: map['name'].toString(),
            total: map['total'],
            prefs: Preferences.fromMap(map['prefs']),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "name": name,
            "total": total,
            "prefs": prefs.toMap(),
        };
    }
}
