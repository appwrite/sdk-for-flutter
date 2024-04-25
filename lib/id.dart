part of 'appwrite.dart';

/// Helper class to generate ID strings for resources.
class ID {
  ID._();

  // Generate an hex ID based on timestamp
  // Recreated from https://www.php.net/manual/en/function.uniqid.php
  static String _hexTimestamp() {
    final now = DateTime.now();
    final sec = (now.millisecondsSinceEpoch / 1000).floor();
    final usec = now.microsecondsSinceEpoch - (sec * 1000000);
    return sec.toRadixString(16) +
        usec.toRadixString(16).padLeft(5, '0');
  }

  // Generate a unique ID with padding to have a longer ID
  static String unique({int padding = 7}) {
    String id = _hexTimestamp();

    if (padding > 0) {
      StringBuffer sb = StringBuffer();
      for (var i = 0; i < padding; i++) {
        sb.write(Random().nextInt(16).toRadixString(16));
      }

      id += sb.toString();
    }

    return id;
  }

  /// Uses [id] as the ID for the resource.
  static String custom(String id) {
    return id;
  }
}
