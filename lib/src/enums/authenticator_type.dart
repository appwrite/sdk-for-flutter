part of appwrite.enums;

enum AuthenticatorType {
    totp(value: 'totp');

    const AuthenticatorType({
        required this.value
    });

    final String value;

    String toJson() => value;
}