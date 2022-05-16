part of appwrite.models;

/// Membership
class Membership implements Model {
    /// Membership ID.
    final String $id;
    /// User ID.
    final String userId;
    /// User name.
    final String userName;
    /// User email address.
    final String userEmail;
    /// Team ID.
    final String teamId;
    /// Team name.
    final String teamName;
    /// Date, the user has been invited to join the team in Unix timestamp.
    final int invited;
    /// Date, the user has accepted the invitation to join the team in Unix timestamp.
    final int joined;
    /// User confirmation status, true if the user has joined the team or false otherwise.
    final bool confirm;
    /// User list of roles
    final List roles;

    Membership({
        required this.$id,
        required this.userId,
        required this.userName,
        required this.userEmail,
        required this.teamId,
        required this.teamName,
        required this.invited,
        required this.joined,
        required this.confirm,
        required this.roles,
    });

    factory Membership.fromMap(Map<String, dynamic> map) {
        return Membership(
            $id: map['\$id'].toString(),
            userId: map['userId'].toString(),
            userName: map['userName'].toString(),
            userEmail: map['userEmail'].toString(),
            teamId: map['teamId'].toString(),
            teamName: map['teamName'].toString(),
            invited: map['invited'],
            joined: map['joined'],
            confirm: map['confirm'],
            roles: map['roles'],
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "userId": userId,
            "userName": userName,
            "userEmail": userEmail,
            "teamId": teamId,
            "teamName": teamName,
            "invited": invited,
            "joined": joined,
            "confirm": confirm,
            "roles": roles,
        };
    }
}
