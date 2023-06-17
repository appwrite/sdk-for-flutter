part of appwrite;

/// The Teams service allows you to group users of your project and to enable
/// them to share read and write access to your project resources
class Teams extends Service {
    /// Initializes a [Teams] service
    Teams(super.client);

    /// List Teams
    ///
    /// Get a list of all the teams in which the current user is a member. You can
    /// use the parameters to filter your results.
    Future<models.TeamList> list({List<String>? queries, String? search}) async {
        const String path = '/teams';

        final Map<String, dynamic> params = {
            'queries': queries,
            'search': search,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.TeamList.fromMap(res.data);

    }

    /// Create Team
    ///
    /// Create a new team. The user who creates the team will automatically be
    /// assigned as the owner of the team. Only the users with the owner role can
    /// invite new members, add new owners and delete or update the team.
    Future<models.Team> create({required String teamId, required String name, List<String>? roles}) async {
        const String path = '/teams';

        final Map<String, dynamic> params = {
            'teamId': teamId,
            'name': name,
            'roles': roles,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Team.fromMap(res.data);

    }

    /// Get Team
    ///
    /// Get a team by its ID. All team members have read access for this resource.
    Future<models.Team> get({required String teamId}) async {
        final String path = '/teams/{teamId}'.replaceAll('{teamId}', teamId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.Team.fromMap(res.data);

    }

    /// Update Name
    ///
    /// Update the team's name by its unique ID.
    Future<models.Team> updateName({required String teamId, required String name}) async {
        final String path = '/teams/{teamId}'.replaceAll('{teamId}', teamId);

        final Map<String, dynamic> params = {
            'name': name,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: path, params: params, headers: headers);

        return models.Team.fromMap(res.data);

    }

    /// Delete Team
    ///
    /// Delete a team using its ID. Only team members with the owner role can
    /// delete the team.
    Future delete({required String teamId}) async {
        final String path = '/teams/{teamId}'.replaceAll('{teamId}', teamId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: path, params: params, headers: headers);

        return  res.data;

    }

    /// List Team Memberships
    ///
    /// Use this endpoint to list a team's members using the team's ID. All team
    /// members have read access to this endpoint.
    Future<models.MembershipList> listMemberships({required String teamId, List<String>? queries, String? search}) async {
        final String path = '/teams/{teamId}/memberships'.replaceAll('{teamId}', teamId);

        final Map<String, dynamic> params = {
            'queries': queries,
            'search': search,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.MembershipList.fromMap(res.data);

    }

    /// Create Team Membership
    ///
    /// Invite a new member to join your team. Provide an ID for existing users, or
    /// invite unregistered users using an email or phone number. If initiated from
    /// a Client SDK, Appwrite will send an email or sms with a link to join the
    /// team to the invited user, and an account will be created for them if one
    /// doesn't exist. If initiated from a Server SDK, the new member will be added
    /// automatically to the team.
    /// 
    /// You only need to provide one of a user ID, email, or phone number. Appwrite
    /// will prioritize accepting the user ID > email > phone number if you provide
    /// more than one of these parameters.
    /// 
    /// Use the `url` parameter to redirect the user from the invitation email to
    /// your app. After the user is redirected, use the [Update Team Membership
    /// Status](/docs/client/teams#teamsUpdateMembershipStatus) endpoint to allow
    /// the user to accept the invitation to the team. 
    /// 
    /// Please note that to avoid a [Redirect
    /// Attack](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.md)
    /// Appwrite will accept the only redirect URLs under the domains you have
    /// added as a platform on the Appwrite Console.
    /// 
    Future<models.Membership> createMembership({required String teamId, required List<String> roles, required String url, String? email, String? userId, String? phone, String? name}) async {
        final String path = '/teams/{teamId}/memberships'.replaceAll('{teamId}', teamId);

        final Map<String, dynamic> params = {
            'email': email,
            'userId': userId,
            'phone': phone,
            'roles': roles,
            'url': url,
            'name': name,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: path, params: params, headers: headers);

        return models.Membership.fromMap(res.data);

    }

    /// Get Team Membership
    ///
    /// Get a team member by the membership unique id. All team members have read
    /// access for this resource.
    Future<models.Membership> getMembership({required String teamId, required String membershipId}) async {
        final String path = '/teams/{teamId}/memberships/{membershipId}'.replaceAll('{teamId}', teamId).replaceAll('{membershipId}', membershipId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.Membership.fromMap(res.data);

    }

    /// Update Membership Roles
    ///
    /// Modify the roles of a team member. Only team members with the owner role
    /// have access to this endpoint. Learn more about [roles and
    /// permissions](/docs/permissions).
    Future<models.Membership> updateMembershipRoles({required String teamId, required String membershipId, required List<String> roles}) async {
        final String path = '/teams/{teamId}/memberships/{membershipId}'.replaceAll('{teamId}', teamId).replaceAll('{membershipId}', membershipId);

        final Map<String, dynamic> params = {
            'roles': roles,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: path, params: params, headers: headers);

        return models.Membership.fromMap(res.data);

    }

    /// Delete Team Membership
    ///
    /// This endpoint allows a user to leave a team or for a team owner to delete
    /// the membership of any other team member. You can also use this endpoint to
    /// delete a user membership even if it is not accepted.
    Future deleteMembership({required String teamId, required String membershipId}) async {
        final String path = '/teams/{teamId}/memberships/{membershipId}'.replaceAll('{teamId}', teamId).replaceAll('{membershipId}', membershipId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: path, params: params, headers: headers);

        return  res.data;

    }

    /// Update Team Membership Status
    ///
    /// Use this endpoint to allow a user to accept an invitation to join a team
    /// after being redirected back to your app from the invitation email received
    /// by the user.
    /// 
    /// If the request is successful, a session for the user is automatically
    /// created.
    /// 
    Future<models.Membership> updateMembershipStatus({required String teamId, required String membershipId, required String userId, required String secret}) async {
        final String path = '/teams/{teamId}/memberships/{membershipId}/status'.replaceAll('{teamId}', teamId).replaceAll('{membershipId}', membershipId);

        final Map<String, dynamic> params = {
            'userId': userId,
            'secret': secret,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.patch, path: path, params: params, headers: headers);

        return models.Membership.fromMap(res.data);

    }

    /// Get Team Preferences
    ///
    /// Get the team's shared preferences by its unique ID. If a preference doesn't
    /// need to be shared by all team members, prefer storing them in [user
    /// preferences](/docs/client/account#accountGetPrefs).
    Future<models.Preferences> getPrefs({required String teamId}) async {
        final String path = '/teams/{teamId}/prefs'.replaceAll('{teamId}', teamId);

        final Map<String, dynamic> params = {
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.get, path: path, params: params, headers: headers);

        return models.Preferences.fromMap(res.data);

    }

    /// Update Preferences
    ///
    /// Update the team's preferences by its unique ID. The object you pass is
    /// stored as is and replaces any previous value. The maximum allowed prefs
    /// size is 64kB and throws an error if exceeded.
    Future<models.Preferences> updatePrefs({required String teamId, required Map prefs}) async {
        final String path = '/teams/{teamId}/prefs'.replaceAll('{teamId}', teamId);

        final Map<String, dynamic> params = {
            'prefs': prefs,
        };

        final Map<String, String> headers = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.put, path: path, params: params, headers: headers);

        return models.Preferences.fromMap(res.data);

    }
}