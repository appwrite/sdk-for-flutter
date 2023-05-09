part of appwrite;

class Role {
    Role._();
    
    static String any() => 'any';
    String status='';
    static String user(String id, status]) {
        if(status.isEmpty) {
            return 'user:$id';
        }
        return 'user:$id/$status';
    }

    static String users(status]) {
        if(status.isEmpty) {
            return 'users';
        }
        return 'users/$status';
    }

    static String guests() => 'guests';

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
