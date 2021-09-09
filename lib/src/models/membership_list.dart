part of appwrite.models;

class MembershipList {
    late final int sum;
    late final List<Membership> memberships;

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
