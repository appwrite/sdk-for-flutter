part of appwrite;

class Permission {
    static String read(String role) {
        return 'read("$role")';
    }
    static String write(String role) {
        return 'write("$role")';
    }
    static String create(String role) {
        return 'create("$role")';
    }
    static String update(String role) {
        return 'update("$role")';
    }
    static String delete(String role) {
        return 'delete("$role")';
    }
}
