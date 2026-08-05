part of '../../models.dart';

/// AppInstallation
class AppInstallation implements Model {
    /// Installation ID.
    final String $id;

    /// Installation creation time in ISO 8601 format.
    final String $createdAt;

    /// Installation update time in ISO 8601 format.
    final String $updatedAt;

    /// ID of the installed application.
    final String appId;

    /// ID of the team the application is installed on.
    final String teamId;

    /// Scopes granted to the application. Snapshot of the application&#039;s installation scopes taken when the installation was created or last updated.
    final List<String> scopes;

    /// Authorization details granted to the application. Rich authorization request (RFC 9396) style entries; the Appwrite Console stores authorized project IDs here.
    final Map<String, dynamic> authorizationDetails;

    /// ID of the user who created the installation.
    final String createdById;

    /// Name of the user who created the installation.
    final String createdByName;

    /// Time an access token was last issued for the installation in ISO 8601 format. Null if never used.
    final String? lastAccessedAt;

    AppInstallation({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.appId,
        required this.teamId,
        required this.scopes,
        required this.authorizationDetails,
        required this.createdById,
        required this.createdByName,
        this.lastAccessedAt,
    });

    factory AppInstallation.fromMap(Map<String, dynamic> map) {
        return AppInstallation(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            appId: map['appId'].toString(),
            teamId: map['teamId'].toString(),
            scopes: List.from(map['scopes'] ?? []),
            authorizationDetails: map['authorizationDetails'],
            createdById: map['createdById'].toString(),
            createdByName: map['createdByName'].toString(),
            lastAccessedAt: map['lastAccessedAt']?.toString(),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "appId": appId,
            "teamId": teamId,
            "scopes": scopes,
            "authorizationDetails": authorizationDetails,
            "createdById": createdById,
            "createdByName": createdByName,
            "lastAccessedAt": lastAccessedAt,
        };
    }
}
