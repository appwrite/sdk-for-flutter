part of appwrite;

class Role {
    Role._();
    
    static String any() {
        return 'any';
    }

    static String user(String id, [String status = '']) {
        if(status.isEmpty) {
            return 'user:$id';
        }
        return 'user:$id/$status';
    }

    static String users([String status = '']) {
        if(status.isEmpty) {
            return 'users';
        }
        return 'users/$status';
    }

    static String guests() {
        return 'guests';
    }

    static String team(String id, [String role = '']) {
        if(role.isEmpty) {
            return 'team:$id';
        }
        return 'team:$id/$role';
    }

    static String member(String id) {
        return 'member:$id';
    }
}