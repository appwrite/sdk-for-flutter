part of appwrite.models;

class Jwt {
    final String jwt;

    Jwt({
        required this.jwt,
    });

    factory Jwt.fromMap(Map<String, dynamic> map) {
        return Jwt(
            jwt: map['jwt'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "jwt": jwt,
        };
    }
}
