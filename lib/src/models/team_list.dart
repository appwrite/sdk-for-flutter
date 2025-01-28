part of '../../models.dart';

/// Teams List
class TeamList implements Model {
    /// Total number of teams documents that matched your query.
    final int total;
    /// List of teams.
    final List<Team> teams;

    TeamList({
        required this.total,
        required this.teams,
    });

    factory TeamList.fromMap(Map<String, dynamic> map) {
        return TeamList(
            total: map['total'],
            teams: List<Team>.from(map['teams'].map((p) => Team.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "teams": teams.map((p) => p.toMap()).toList(),
        };
    }
}