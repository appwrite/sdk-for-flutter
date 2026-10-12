part of '../../models.dart';

/// OAuth2 Organization
class Oauth2Organization implements Model {
  /// Organization ID.
  final String $id;

  Oauth2Organization({
    required this.$id,
  });
  factory Oauth2Organization.fromMap(
    Map<String, dynamic> map,
  ) {
    return Oauth2Organization(
      $id: map['\$id'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
    };
  }
}
