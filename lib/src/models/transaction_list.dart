part of '../../models.dart';

/// Transaction List
class TransactionList implements Model {
  /// Total number of transactions that matched your query.
  final int total;

  /// List of transactions.
  final List<Transaction> transactions;

  TransactionList({
    required this.total,
    required this.transactions,
  });

  factory TransactionList.fromMap(Map<String, dynamic> map) {
    return TransactionList(
      total: map['total'],
      transactions: List<Transaction>.from(
          map['transactions'].map((p) => Transaction.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "transactions": transactions.map((p) => p.toMap()).toList(),
    };
  }
}
