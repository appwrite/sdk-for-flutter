part of appwrite.models;

/// Memberships List
class MembershipList {
    /// Total sum of items in the list.
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
            memberships: List<Membership>.from(map['memberships'].map((p) => Membership.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "memberships": memberships.map((p) => p.toMap()),
        };
    }
}
