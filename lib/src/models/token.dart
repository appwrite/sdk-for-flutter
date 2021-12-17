part of appwrite.models;

/// Token
class Token implements Model {
    /// Token ID.
    final String $id;
    /// User ID.
    final String userId;
    /// Token secret key. This will return an empty string unless the response is returned using an API key or as part of a webhook payload.
    final String secret;
    /// Token expiration date in Unix timestamp.
    final int expire;

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

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "userId": userId,
            "secret": secret,
            "expire": expire,
        };
    }
}
