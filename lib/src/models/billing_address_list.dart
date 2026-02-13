part of '../../models.dart';

/// Billing address list
class BillingAddressList implements Model {
  /// Total number of billingAddresses that matched your query.
  final int total;

  /// List of billingAddresses.
  final List<BillingAddress> billingAddresses;

  BillingAddressList({
    required this.total,
    required this.billingAddresses,
  });

  factory BillingAddressList.fromMap(Map<String, dynamic> map) {
    return BillingAddressList(
      total: map['total'],
      billingAddresses: List<BillingAddress>.from(
          map['billingAddresses'].map((p) => BillingAddress.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "billingAddresses": billingAddresses.map((p) => p.toMap()).toList(),
    };
  }
}
