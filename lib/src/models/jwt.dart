part of appwrite.models;

/// JWT
class Jwt implements Model {
    /// JWT encoded string.
    final String jwt;

    Jwt({
        required this.jwt,
    });

    factory Jwt.fromMap(Map<String, dynamic> map) {
        return Jwt(
            jwt: map['jwt'],
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "jwt": jwt,
        };
    }
}
