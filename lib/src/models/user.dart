part of appwrite.models;

/// User
class User implements Model {
  /// User ID.
  final String $id;

  /// User creation date in Unix timestamp.
  final int $createdAt;

  /// User update date in Unix timestamp.
  final int $updatedAt;

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

  /// User phone number in E.164 format.
  final String phone;

  /// Email verification status.
  final bool emailVerification;

  /// Phone verification status.
  final bool phoneVerification;

  /// User preferences as a key-value object
  final Preferences prefs;

  User({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.name,
    required this.registration,
    required this.status,
    required this.passwordUpdate,
    required this.email,
    required this.phone,
    required this.emailVerification,
    required this.phoneVerification,
    required this.prefs,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'],
      $updatedAt: map['\$updatedAt'],
      name: map['name'].toString(),
      registration: map['registration'],
      status: map['status'],
      passwordUpdate: map['passwordUpdate'],
      email: map['email'].toString(),
      phone: map['phone'].toString(),
      emailVerification: map['emailVerification'],
      phoneVerification: map['phoneVerification'],
      prefs: Preferences.fromMap(map['prefs']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "name": name,
      "registration": registration,
      "status": status,
      "passwordUpdate": passwordUpdate,
      "email": email,
      "phone": phone,
      "emailVerification": emailVerification,
      "phoneVerification": phoneVerification,
      "prefs": prefs.toMap(),
    };
  }
}
