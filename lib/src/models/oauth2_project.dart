part of '../../models.dart';

/// OAuth2 Project
class Oauth2Project implements Model {
  /// Project ID.
  final String $id;

  /// Region ID the project is deployed in.
  final String region;

  /// API endpoint of the region the project is deployed in. Empty when the region has no public hostname configured.
  final String endpoint;

  Oauth2Project({
    required this.$id,
    required this.region,
    required this.endpoint,
  });
  factory Oauth2Project.fromMap(
    Map<String, dynamic> map,
  ) {
    return Oauth2Project(
      $id: map['\$id'].toString(),
      region: map['region'].toString(),
      endpoint: map['endpoint'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "region": region,
      "endpoint": endpoint,
    };
  }
}
