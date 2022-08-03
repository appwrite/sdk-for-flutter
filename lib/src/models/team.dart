part of appwrite.models;

/// Team
class Team implements Model {
  /// Team ID.
  final String $id;

  /// Team creation date in Unix timestamp.
  final int $createdAt;

  /// Team update date in Unix timestamp.
  final int $updatedAt;

  /// Team name.
  final String name;

  /// Total number of team members.
  final int total;

  Team({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.name,
    required this.total,
  });

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'],
      $updatedAt: map['\$updatedAt'],
      name: map['name'].toString(),
      total: map['total'],
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
    };
  }
}
