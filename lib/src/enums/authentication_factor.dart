part of '../../enums.dart';

enum AuthenticationFactor {
    email(value: 'email'),
    phone(value: 'phone'),
    totp(value: 'totp'),
    recoverycode(value: 'recoverycode');

    const AuthenticationFactor({
        required this.value
    });

    final String value;

    String toJson() => value;
}