part of '../../models.dart';

/// User
class User implements Model {
    /// User ID.
    final String $id;
    /// User creation date in ISO 8601 format.
    final String $createdAt;
    /// User update date in ISO 8601 format.
    final String $updatedAt;
    /// User name.
    final String name;
    /// Hashed user password.
    final String? password;
    /// Password hashing algorithm.
    final String? hash;
    /// Password hashing algorithm configuration.
    final Map? hashOptions;
    /// User registration date in ISO 8601 format.
    final String registration;
    /// User status. Pass `true` for enabled and `false` for disabled.
    final bool status;
    /// Labels for the user.
    final List<String> labels;
    /// Password update time in ISO 8601 format.
    final String passwordUpdate;
    /// User email address.
    final String email;
    /// User phone number in E.164 format.
    final String phone;
    /// Email verification status.
    final bool emailVerification;
    /// Phone verification status.
    final bool phoneVerification;
    /// Multi factor authentication status.
    final bool mfa;
    /// User preferences as a key-value object
    final Preferences prefs;
    /// A user-owned message receiver. A single user may have multiple e.g. emails, phones, and a browser. Each target is registered with a single provider.
    final List<Target> targets;
    /// Most recent access date in ISO 8601 format. This attribute is only updated again after 24 hours.
    final String accessedAt;

    User({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.name,
        this.password,
        this.hash,
        this.hashOptions,
        required this.registration,
        required this.status,
        required this.labels,
        required this.passwordUpdate,
        required this.email,
        required this.phone,
        required this.emailVerification,
        required this.phoneVerification,
        required this.mfa,
        required this.prefs,
        required this.targets,
        required this.accessedAt,
    });

    factory User.fromMap(Map<String, dynamic> map) {
        return User(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            name: map['name'].toString(),
            password: map['password']?.toString(),
            hash: map['hash']?.toString(),
            hashOptions: map['hashOptions'],
            registration: map['registration'].toString(),
            status: map['status'],
            labels: map['labels'] ?? [],
            passwordUpdate: map['passwordUpdate'].toString(),
            email: map['email'].toString(),
            phone: map['phone'].toString(),
            emailVerification: map['emailVerification'],
            phoneVerification: map['phoneVerification'],
            mfa: map['mfa'],
            prefs: Preferences.fromMap(map['prefs']),
            targets: List<Target>.from(map['targets'].map((p) => Target.fromMap(p))),
            accessedAt: map['accessedAt'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "name": name,
            "password": password,
            "hash": hash,
            "hashOptions": hashOptions,
            "registration": registration,
            "status": status,
            "labels": labels,
            "passwordUpdate": passwordUpdate,
            "email": email,
            "phone": phone,
            "emailVerification": emailVerification,
            "phoneVerification": phoneVerification,
            "mfa": mfa,
            "prefs": prefs.toMap(),
            "targets": targets.map((p) => p.toMap()).toList(),
            "accessedAt": accessedAt,
        };
    }
}
