part of appwrite;

/// Helper class to generate permission strings for resources.
class Permission {
  Permission._();

  /// Read permission for provided [role]
  static String read(String role) {
    return 'read("$role")';
  }

  /// Write permission for provided [role]
  ///
  /// This is an alias of update, delete, and possibly create.
  /// Don't use write in combination with update, delete, or create.
  static String write(String role) {
    return 'write("$role")';
  }

  /// Create permission for provided [role]
  static String create(String role) {
    return 'create("$role")';
  }

  /// Update permission for provided [role]
  static String update(String role) {
    return 'update("$role")';
  }

  /// Delete permission for provided [role]
  static String delete(String role) {
    return 'delete("$role")';
  }
}
