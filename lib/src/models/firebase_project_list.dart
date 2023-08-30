part of appwrite.models;

/// Migrations Firebase Projects List
class FirebaseProjectList implements Model {
    /// Total number of projects documents that matched your query.
    final int total;
    /// List of projects.
    final List<FirebaseProject> projects;

    FirebaseProjectList({
        required this.total,
        required this.projects,
    });

    factory FirebaseProjectList.fromMap(Map<String, dynamic> map) {
        return FirebaseProjectList(
            total: map['total'],
            projects: List<FirebaseProject>.from(map['projects'].map((p) => FirebaseProject.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "projects": projects.map((p) => p.toMap()).toList(),
        };
    }
}
