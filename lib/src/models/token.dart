part of appwrite.models;

class Token {
    late final String $id;
    late final String userId;
    late final String secret;
    late final int expire;

    Token({
        required this.$id,
        required this.userId,
        required this.secret,
        required this.expire,
    });

    factory Token.fromMap(Map<String, dynamic> map) {
        return Token(
            $id: map['\$id'],
            userId: map['userId'],
            secret: map['secret'],
            expire: map['expire'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "userId": userId,
            "secret": secret,
            "expire": expire,
        };
    }

}
