part of '../../models.dart';

/// MFAFactors
class MfaFactors implements Model {
    /// TOTP
    final bool totp;
    /// Phone
    final bool phone;
    /// Email
    final bool email;

    MfaFactors({
        required this.totp,
        required this.phone,
        required this.email,
    });

    factory MfaFactors.fromMap(Map<String, dynamic> map) {
        return MfaFactors(
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
