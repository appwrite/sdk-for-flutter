part of appwrite.models;

/// MigrationFirebaseProject
class FirebaseProject implements Model {
    /// Project ID.
    final String projectId;
    /// Project display name.
    final String displayName;

    FirebaseProject({
        required this.projectId,
        required this.displayName,
    });

    factory FirebaseProject.fromMap(Map<String, dynamic> map) {
        return FirebaseProject(
            projectId: map['projectId'].toString(),
            displayName: map['displayName'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "projectId": projectId,
            "displayName": displayName,
        };
    }
}
