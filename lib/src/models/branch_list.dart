part of appwrite.models;

/// Branches List
class BranchList implements Model {
    /// Total number of branches documents that matched your query.
    final int total;
    /// List of branches.
    final List<Branch> branches;

    BranchList({
        required this.total,
        required this.branches,
    });

    factory BranchList.fromMap(Map<String, dynamic> map) {
        return BranchList(
            total: map['total'],
            branches: List<Branch>.from(map['branches'].map((p) => Branch.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "branches": branches.map((p) => p.toMap()).toList(),
        };
    }
}
