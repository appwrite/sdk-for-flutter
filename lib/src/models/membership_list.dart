part of appwrite.models;

/// Memberships List
class MembershipList implements Model {
  /// Total number of items available on the server.
  final int sum;

  /// List of memberships.
  final List<Membership> memberships;

  MembershipList({
    required this.sum,
    required this.memberships,
  });

  factory MembershipList.fromMap(Map<String, dynamic> map) {
    return MembershipList(
      sum: map['sum'],
      memberships: List<Membership>.from(
          map['memberships'].map((p) => Membership.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "sum": sum,
      "memberships": memberships.map((p) => p.toMap()),
    };
  }
}
