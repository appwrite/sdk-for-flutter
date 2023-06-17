part of appwrite;

/// Helper class to generate role strings for [Permission].
class Role {
    Role._();
    
    /// Grants access to anyone.
    /// 
    /// This includes authenticated and unauthenticated users.
    static String any() {
        return 'any';
    }

    /// Grants access to a specific user by user ID.
    /// 
    /// You can optionally pass verified or unverified for
    /// [status] to target specific types of users.
    static String user(String id, [String status = '']) {
        if(status.isEmpty) {
            return 'user:$id';
        }
        return 'user:$id/$status';
    }

    /// Grants access to any authenticated or anonymous user.
    /// 
    /// You can optionally pass verified or unverified for
    /// [status] to target specific types of users.
    static String users([String status = '']) {
        if(status.isEmpty) {
            return 'users';
        }
        return 'users/$status';
    }

    /// Grants access to any guest user without a session.
    /// 
    /// Authenticated users don't have access to this role.
    static String guests() {
        return 'guests';
    }

    /// Grants access to a team by team ID.
    /// 
    /// You can optionally pass a role for [role] to target
    /// team members with the specified role.
    static String team(String id, [String role = '']) {
        if(role.isEmpty) {
            return 'team:$id';
        }
        return 'team:$id/$role';
    }

    /// Grants access to a specific member of a team.
    /// 
    /// When the member is removed from the team, they will
    /// no longer have access.
    static String member(String id) {
        return 'member:$id';
    }
}