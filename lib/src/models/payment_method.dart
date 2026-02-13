part of '../../models.dart';

/// paymentMethod
class PaymentMethod implements Model {
    /// Payment Method ID.
    final String $id;

    /// Payment method creation time in ISO 8601 format.
    final String $createdAt;

    /// Payment method update date in ISO 8601 format.
    final String $updatedAt;

    /// Payment method permissions. [Learn more about permissions](/docs/permissions).
    final List<String> $permissions;

    /// Payment method ID from the payment provider
    final String providerMethodId;

    /// Client secret hash for payment setup
    final String clientSecret;

    /// User ID from the payment provider.
    final String providerUserId;

    /// ID of the Team.
    final String userId;

    /// Expiry month of the payment method.
    final int expiryMonth;

    /// Expiry year of the payment method.
    final int expiryYear;

    /// Last 4 digit of the payment method
    final String last4;

    /// Payment method brand
    final String brand;

    /// Name of the owner
    final String name;

    /// Mandate ID of the payment method
    final String mandateId;

    /// Country of the payment method
    final String country;

    /// State of the payment method
    final String state;

    /// Last payment error associated with the payment method.
    final String lastError;

    /// True when it&#039;s the default payment method.
    final bool xdefault;

    /// True when payment method has expired.
    final bool expired;

    /// True when payment method has failed to process multiple times.
    final bool failed;

    PaymentMethod({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.$permissions,
        required this.providerMethodId,
        required this.clientSecret,
        required this.providerUserId,
        required this.userId,
        required this.expiryMonth,
        required this.expiryYear,
        required this.last4,
        required this.brand,
        required this.name,
        required this.mandateId,
        required this.country,
        required this.state,
        required this.lastError,
        required this.xdefault,
        required this.expired,
        required this.failed,
    });

    factory PaymentMethod.fromMap(Map<String, dynamic> map) {
        return PaymentMethod(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            $permissions: List.from(map['\$permissions'] ?? []),
            providerMethodId: map['providerMethodId'].toString(),
            clientSecret: map['clientSecret'].toString(),
            providerUserId: map['providerUserId'].toString(),
            userId: map['userId'].toString(),
            expiryMonth: map['expiryMonth'],
            expiryYear: map['expiryYear'],
            last4: map['last4'].toString(),
            brand: map['brand'].toString(),
            name: map['name'].toString(),
            mandateId: map['mandateId'].toString(),
            country: map['country'].toString(),
            state: map['state'].toString(),
            lastError: map['lastError'].toString(),
            xdefault: map['default'],
            expired: map['expired'],
            failed: map['failed'],
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "\$permissions": $permissions,
            "providerMethodId": providerMethodId,
            "clientSecret": clientSecret,
            "providerUserId": providerUserId,
            "userId": userId,
            "expiryMonth": expiryMonth,
            "expiryYear": expiryYear,
            "last4": last4,
            "brand": brand,
            "name": name,
            "mandateId": mandateId,
            "country": country,
            "state": state,
            "lastError": lastError,
            "default": xdefault,
            "expired": expired,
            "failed": failed,
        };
    }
}
