part of appwrite.enums;

enum AuthenticationFactor {
    totp(value: 'totp'),
    phone(value: 'phone'),
    email(value: 'email');

    const AuthenticationFactor({
        required this.value
    });

    final String value;

    String toJson() => value;
}