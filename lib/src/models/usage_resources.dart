part of '../../models.dart';

/// UsageResource
class UsageResources implements Model {
    /// Invoice name
    final String name;

    /// Invoice value
    final int value;

    /// Invoice amount
    final double amount;

    /// Invoice rate
    final double rate;

    /// Invoice description
    final String desc;

    /// Resource ID
    final String resourceId;

    UsageResources({
        required this.name,
        required this.value,
        required this.amount,
        required this.rate,
        required this.desc,
        required this.resourceId,
    });

    factory UsageResources.fromMap(Map<String, dynamic> map) {
        return UsageResources(
            name: map['name'].toString(),
            value: map['value'],
            amount: map['amount'].toDouble(),
            rate: map['rate'].toDouble(),
            desc: map['desc'].toString(),
            resourceId: map['resourceId'].toString(),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "name": name,
            "value": value,
            "amount": amount,
            "rate": rate,
            "desc": desc,
            "resourceId": resourceId,
        };
    }
}
