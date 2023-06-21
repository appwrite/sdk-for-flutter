part of appwrite;

/// Helper class to generate ID strings for resources.
class ID {
  ID._();

  /// Have Appwrite generate a unique ID for you.
  static String unique() {
    return 'unique()';
  }

  /// Uses [id] as the ID for the resource.
  static String custom(String id) {
    return id;
  }
}