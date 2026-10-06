part of '../../models.dart';

/// OAuth2 accessible projects list
class Oauth2ProjectList implements Model {
  /// Total number of projects that matched your query.
  final int total;

  /// List of projects.
  final List<Oauth2Project> projects;

  Oauth2ProjectList({
    required this.total,
    required this.projects,
  });
  factory Oauth2ProjectList.fromMap(
    Map<String, dynamic> map,
  ) {
    return Oauth2ProjectList(
      total: map['total'],
      projects: List<Oauth2Project>.from(
        map['projects'].map((p) => Oauth2Project.fromMap(p)),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "projects": projects.map((p) => p.toMap()).toList(),
    };
  }
}
