part of appwrite.models;

/// User
class User implements Model {
  /// User ID.
  final String $id;

  /// User name.
  final String name;

  /// User registration date in Unix timestamp.
  final int registration;

  /// User status. Pass `true` for enabled and `false` for disabled.
  final bool status;

  /// Unix timestamp of the most recent password update
  final int passwordUpdate;

  /// User email address.
  final String email;

  /// Email verification status.
  final bool emailVerification;

  /// User preferences as a key-value object
  final Preferences prefs;

  User({
    required this.$id,
    required this.name,
    required this.registration,
    required this.status,
    required this.passwordUpdate,
    required this.email,
    required this.emailVerification,
    required this.prefs,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      $id: map['\$id'].toString(),
      name: map['name'].toString(),
      registration: map['registration'],
      status: map['status'],
      passwordUpdate: map['passwordUpdate'],
      email: map['email'].toString(),
      emailVerification: map['emailVerification'],
      prefs: Preferences.fromMap(map['prefs']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "name": name,
      "registration": registration,
      "status": status,
      "passwordUpdate": passwordUpdate,
      "email": email,
      "emailVerification": emailVerification,
      "prefs": prefs.toMap(),
    };
  }
}
