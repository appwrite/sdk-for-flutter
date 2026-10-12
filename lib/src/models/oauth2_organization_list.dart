part of '../../models.dart';

/// OAuth2 accessible organizations list
class Oauth2OrganizationList implements Model {
  /// Total number of organizations that matched your query.
  final int total;

  /// List of organizations.
  final List<Oauth2Organization> organizations;

  Oauth2OrganizationList({
    required this.total,
    required this.organizations,
  });
  factory Oauth2OrganizationList.fromMap(
    Map<String, dynamic> map,
  ) {
    return Oauth2OrganizationList(
      total: map['total'],
      organizations: List<Oauth2Organization>.from(
        map['organizations'].map((p) => Oauth2Organization.fromMap(p)),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "organizations": organizations.map((p) => p.toMap()).toList(),
    };
  }
}
