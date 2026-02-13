part of '../../models.dart';

/// EstimationDeleteOrganization
class EstimationDeleteOrganization implements Model {
  /// List of unpaid invoices
  final List<Invoice> unpaidInvoices;

  EstimationDeleteOrganization({
    required this.unpaidInvoices,
  });

  factory EstimationDeleteOrganization.fromMap(Map<String, dynamic> map) {
    return EstimationDeleteOrganization(
      unpaidInvoices: List<Invoice>.from(
          map['unpaidInvoices'].map((p) => Invoice.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "unpaidInvoices": unpaidInvoices.map((p) => p.toMap()).toList(),
    };
  }
}
