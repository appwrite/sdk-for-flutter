part of '../../models.dart';

/// Invoice
class Invoice implements Model {
    /// Invoice ID.
    final String $id;

    /// Invoice creation time in ISO 8601 format.
    final String $createdAt;

    /// Invoice update date in ISO 8601 format.
    final String $updatedAt;

    /// Invoice permissions. [Learn more about permissions](/docs/permissions).
    final List<String> $permissions;

    /// Project ID
    final String teamId;

    /// Aggregation ID
    final String aggregationId;

    /// Billing plan selected. Can be one of `tier-0`, `tier-1` or `tier-2`.
    final String plan;

    /// Usage breakdown per resource
    final List<UsageResources> usage;

    /// Invoice Amount
    final double amount;

    /// Tax percentage
    final double tax;

    /// Tax amount
    final double taxAmount;

    /// VAT percentage
    final double vat;

    /// VAT amount
    final double vatAmount;

    /// Gross amount after vat, tax, and discounts applied.
    final double grossAmount;

    /// Credits used.
    final double creditsUsed;

    /// Currency the invoice is in
    final String currency;

    /// Client secret for processing failed payments in front-end
    final String clientSecret;

    /// Invoice status
    final String status;

    /// Last payment error associated with the invoice
    final String lastError;

    /// Invoice due date.
    final String dueAt;

    /// Beginning date of the invoice
    final String from;

    /// End date of the invoice
    final String to;

    Invoice({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.$permissions,
        required this.teamId,
        required this.aggregationId,
        required this.plan,
        required this.usage,
        required this.amount,
        required this.tax,
        required this.taxAmount,
        required this.vat,
        required this.vatAmount,
        required this.grossAmount,
        required this.creditsUsed,
        required this.currency,
        required this.clientSecret,
        required this.status,
        required this.lastError,
        required this.dueAt,
        required this.from,
        required this.to,
    });

    factory Invoice.fromMap(Map<String, dynamic> map) {
        return Invoice(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            $permissions: List.from(map['\$permissions'] ?? []),
            teamId: map['teamId'].toString(),
            aggregationId: map['aggregationId'].toString(),
            plan: map['plan'].toString(),
            usage: List<UsageResources>.from(map['usage'].map((p) => UsageResources.fromMap(p))),
            amount: map['amount'].toDouble(),
            tax: map['tax'].toDouble(),
            taxAmount: map['taxAmount'].toDouble(),
            vat: map['vat'].toDouble(),
            vatAmount: map['vatAmount'].toDouble(),
            grossAmount: map['grossAmount'].toDouble(),
            creditsUsed: map['creditsUsed'].toDouble(),
            currency: map['currency'].toString(),
            clientSecret: map['clientSecret'].toString(),
            status: map['status'].toString(),
            lastError: map['lastError'].toString(),
            dueAt: map['dueAt'].toString(),
            from: map['from'].toString(),
            to: map['to'].toString(),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "\$permissions": $permissions,
            "teamId": teamId,
            "aggregationId": aggregationId,
            "plan": plan,
            "usage": usage.map((p) => p.toMap()).toList(),
            "amount": amount,
            "tax": tax,
            "taxAmount": taxAmount,
            "vat": vat,
            "vatAmount": vatAmount,
            "grossAmount": grossAmount,
            "creditsUsed": creditsUsed,
            "currency": currency,
            "clientSecret": clientSecret,
            "status": status,
            "lastError": lastError,
            "dueAt": dueAt,
            "from": from,
            "to": to,
        };
    }
}
