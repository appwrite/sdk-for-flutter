part of '../../models.dart';

/// Payment methods list
class PaymentMethodList implements Model {
  /// Total number of paymentMethods that matched your query.
  final int total;

  /// List of paymentMethods.
  final List<PaymentMethod> paymentMethods;

  PaymentMethodList({
    required this.total,
    required this.paymentMethods,
  });

  factory PaymentMethodList.fromMap(Map<String, dynamic> map) {
    return PaymentMethodList(
      total: map['total'],
      paymentMethods: List<PaymentMethod>.from(
          map['paymentMethods'].map((p) => PaymentMethod.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "paymentMethods": paymentMethods.map((p) => p.toMap()).toList(),
    };
  }
}
