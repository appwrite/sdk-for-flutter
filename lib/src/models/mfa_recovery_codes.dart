part of '../../models.dart';

/// MFA Recovery Codes
class MfaRecoveryCodes implements Model {
    /// Recovery codes.
    final List<String> recoveryCodes;

    MfaRecoveryCodes({
        required this.recoveryCodes,
    });

    factory MfaRecoveryCodes.fromMap(Map<String, dynamic> map) {
        return MfaRecoveryCodes(
            recoveryCodes: List.from(map['recoveryCodes'] ?? []),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "recoveryCodes": recoveryCodes,
        };
    }
}
