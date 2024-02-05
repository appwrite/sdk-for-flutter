part of appwrite.models;

/// MFAProviders
class MfaProviders implements Model {
    /// TOTP
    final bool totp;
    /// Phone
    final bool phone;
    /// Email
    final bool email;

    MfaProviders({
        required this.totp,
        required this.phone,
        required this.email,
    });

    factory MfaProviders.fromMap(Map<String, dynamic> map) {
        return MfaProviders(
            totp: map['totp'],
            phone: map['phone'],
            email: map['email'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "totp": totp,
            "phone": phone,
            "email": email,
        };
    }
}
