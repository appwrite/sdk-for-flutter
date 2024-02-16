part of appwrite.enums;

enum Type {
    totp(value: 'totp');

    const Type({
        required this.value
    });

    final String value;

    String toJson() => value;
}