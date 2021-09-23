part of appwrite.models;

class User {
    final String $id;
    final String name;
    final int registration;
    final int status;
    final int passwordUpdate;
    final String email;
    final bool emailVerification;
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
            $id: map['\$id'],
            name: map['name'],
            registration: map['registration'],
            status: map['status'],
            passwordUpdate: map['passwordUpdate'],
            email: map['email'],
            emailVerification: map['emailVerification'],
            prefs: Preferences.fromMap(map['prefs']),
        );
    }

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
