part of appwrite;

class Role {
    static String any() {
        return 'any';
    }

    static String user(String id) {
        return 'user:$id';
    }

    static String users() {
        return 'users';
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
    
    static String status(String status) {
        return 'status:$status';
    }
}