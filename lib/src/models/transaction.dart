part of '../../models.dart';

/// Transaction
class Transaction implements Model {
  /// Transaction ID.
  final String $id;

  /// Transaction creation time in ISO 8601 format.
  final String $createdAt;

  /// Transaction update date in ISO 8601 format.
  final String $updatedAt;

  /// Current status of the transaction. One of: pending, committing, committed, rolled_back, failed.
  final String status;

  /// Number of operations in the transaction.
  final int operations;

  /// Expiration time in ISO 8601 format.
  final String expiresAt;

  Transaction({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.status,
    required this.operations,
    required this.expiresAt,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      status: map['status'].toString(),
      operations: map['operations'],
      expiresAt: map['expiresAt'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "status": status,
      "operations": operations,
      "expiresAt": expiresAt,
    };
  }
}
