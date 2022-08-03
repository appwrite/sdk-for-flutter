part of appwrite;

/// The Teams service allows you to group users of your project and to enable
/// them to share read and write access to your project resources
class Teams extends Service {
  Teams(Client client) : super(client);

  /// List Teams
  ///
  /// Get a list of all the teams in which the current user is a member. You can
  /// use the parameters to filter your results.
  ///
  /// In admin mode, this endpoint returns a list of all the teams in the current
  /// project. [Learn more about different API modes](/docs/admin).
  ///
  Future<models.TeamList> list(
      {String? search,
      int? limit,
      int? offset,
      String? cursor,
      String? cursorDirection,
      String? orderType}) async {
    const String path = '/teams';

    final Map<String, dynamic> params = {
      'search': search,
      'limit': limit,
      'offset': offset,
      'cursor': cursor,
      'cursorDirection': cursorDirection,
      'orderType': orderType,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: path, params: params, headers: headers);

    return models.TeamList.fromMap(res.data);
  }

  /// Create Team
  ///
  /// Create a new team. The user who creates the team will automatically be
  /// assigned as the owner of the team. Only the users with the owner role can
  /// invite new members, add new owners and delete or update the team.
  ///
  Future<models.Team> create(
      {required String teamId, required String name, List? roles}) async {
    const String path = '/teams';

    final Map<String, dynamic> params = {
      'teamId': teamId,
      'name': name,
      'roles': roles,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.post,
        path: path, params: params, headers: headers);

    return models.Team.fromMap(res.data);
  }

  /// Get Team
  ///
  /// Get a team by its ID. All team members have read access for this resource.
  ///
  Future<models.Team> get({required String teamId}) async {
    final String path = '/teams/{teamId}'.replaceAll('{teamId}', teamId);

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: path, params: params, headers: headers);

    return models.Team.fromMap(res.data);
  }

  /// Update Team
  ///
  /// Update a team using its ID. Only members with the owner role can update the
  /// team.
  ///
  Future<models.Team> update(
      {required String teamId, required String name}) async {
    final String path = '/teams/{teamId}'.replaceAll('{teamId}', teamId);

    final Map<String, dynamic> params = {
      'name': name,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.put,
        path: path, params: params, headers: headers);

    return models.Team.fromMap(res.data);
  }

  /// Delete Team
  ///
  /// Delete a team using its ID. Only team members with the owner role can
  /// delete the team.
  ///
  Future delete({required String teamId}) async {
    final String path = '/teams/{teamId}'.replaceAll('{teamId}', teamId);

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.delete,
        path: path, params: params, headers: headers);

    return res.data;
  }

  /// Get Team Memberships
  ///
  /// Use this endpoint to list a team's members using the team's ID. All team
  /// members have read access to this endpoint.
  ///
  Future<models.MembershipList> getMemberships(
      {required String teamId,
      String? search,
      int? limit,
      int? offset,
      String? cursor,
      String? cursorDirection,
      String? orderType}) async {
    final String path =
        '/teams/{teamId}/memberships'.replaceAll('{teamId}', teamId);

    final Map<String, dynamic> params = {
      'search': search,
      'limit': limit,
      'offset': offset,
      'cursor': cursor,
      'cursorDirection': cursorDirection,
      'orderType': orderType,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: path, params: params, headers: headers);

    return models.MembershipList.fromMap(res.data);
  }

  /// Create Team Membership
  ///
  /// Invite a new member to join your team. If initiated from the client SDK, an
  /// email with a link to join the team will be sent to the member's email
  /// address and an account will be created for them should they not be signed
  /// up already. If initiated from server-side SDKs, the new member will
  /// automatically be added to the team.
  ///
  /// Use the 'url' parameter to redirect the user from the invitation email back
  /// to your app. When the user is redirected, use the [Update Team Membership
  /// Status](/docs/client/teams#teamsUpdateMembershipStatus) endpoint to allow
  /// the user to accept the invitation to the team.
  ///
  /// Please note that to avoid a [Redirect
  /// Attack](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.md)
  /// the only valid redirect URL's are the once from domains you have set when
  /// adding your platforms in the console interface.
  ///
  Future<models.Membership> createMembership(
      {required String teamId,
      required String email,
      required List roles,
      required String url,
      String? name}) async {
    final String path =
        '/teams/{teamId}/memberships'.replaceAll('{teamId}', teamId);

    final Map<String, dynamic> params = {
      'email': email,
      'roles': roles,
      'url': url,
      'name': name,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.post,
        path: path, params: params, headers: headers);

    return models.Membership.fromMap(res.data);
  }

  /// Get Team Membership
  ///
  /// Get a team member by the membership unique id. All team members have read
  /// access for this resource.
  ///
  Future<models.MembershipList> getMembership(
      {required String teamId, required String membershipId}) async {
    final String path = '/teams/{teamId}/memberships/{membershipId}'
        .replaceAll('{teamId}', teamId)
        .replaceAll('{membershipId}', membershipId);

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: path, params: params, headers: headers);

    return models.MembershipList.fromMap(res.data);
  }

  /// Update Membership Roles
  ///
  /// Modify the roles of a team member. Only team members with the owner role
  /// have access to this endpoint. Learn more about [roles and
  /// permissions](/docs/permissions).
  ///
  Future<models.Membership> updateMembershipRoles(
      {required String teamId,
      required String membershipId,
      required List roles}) async {
    final String path = '/teams/{teamId}/memberships/{membershipId}'
        .replaceAll('{teamId}', teamId)
        .replaceAll('{membershipId}', membershipId);

    final Map<String, dynamic> params = {
      'roles': roles,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.patch,
        path: path, params: params, headers: headers);

    return models.Membership.fromMap(res.data);
  }

  /// Delete Team Membership
  ///
  /// This endpoint allows a user to leave a team or for a team owner to delete
  /// the membership of any other team member. You can also use this endpoint to
  /// delete a user membership even if it is not accepted.
  ///
  Future deleteMembership(
      {required String teamId, required String membershipId}) async {
    final String path = '/teams/{teamId}/memberships/{membershipId}'
        .replaceAll('{teamId}', teamId)
        .replaceAll('{membershipId}', membershipId);

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.delete,
        path: path, params: params, headers: headers);

    return res.data;
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
  ///
  Future<models.Membership> updateMembershipStatus(
      {required String teamId,
      required String membershipId,
      required String userId,
      required String secret}) async {
    final String path = '/teams/{teamId}/memberships/{membershipId}/status'
        .replaceAll('{teamId}', teamId)
        .replaceAll('{membershipId}', membershipId);

    final Map<String, dynamic> params = {
      'userId': userId,
      'secret': secret,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.patch,
        path: path, params: params, headers: headers);

    return models.Membership.fromMap(res.data);
  }
}
