part of '../../models.dart';

/// BillingAddress
class BillingAddress implements Model {
    /// Region ID
    final String $id;

    /// User ID
    final String userId;

    /// Street address
    final String streetAddress;

    /// Address line 2
    final String addressLine2;

    /// Address country
    final String country;

    /// city
    final String city;

    /// state
    final String state;

    /// postal code
    final String postalCode;

    BillingAddress({
        required this.$id,
        required this.userId,
        required this.streetAddress,
        required this.addressLine2,
        required this.country,
        required this.city,
        required this.state,
        required this.postalCode,
    });

    factory BillingAddress.fromMap(Map<String, dynamic> map) {
        return BillingAddress(
            $id: map['\$id'].toString(),
            userId: map['userId'].toString(),
            streetAddress: map['streetAddress'].toString(),
            addressLine2: map['addressLine2'].toString(),
            country: map['country'].toString(),
            city: map['city'].toString(),
            state: map['state'].toString(),
            postalCode: map['postalCode'].toString(),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "userId": userId,
            "streetAddress": streetAddress,
            "addressLine2": addressLine2,
            "country": country,
            "city": city,
            "state": state,
            "postalCode": postalCode,
        };
    }
}
