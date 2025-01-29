part of '../../models.dart';

/// Memberships List
class MembershipList implements Model {
    /// Total number of memberships documents that matched your query.
    final int total;
    /// List of memberships.
    final List<Membership> memberships;

    MembershipList({
        required this.total,
        required this.memberships,
    });

    factory MembershipList.fromMap(Map<String, dynamic> map) {
        return MembershipList(
            total: map['total'],
            memberships: List<Membership>.from(map['memberships'].map((p) => Membership.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "memberships": memberships.map((p) => p.toMap()).toList(),
        };
    }
}