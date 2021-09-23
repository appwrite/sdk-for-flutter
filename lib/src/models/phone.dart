part of appwrite.models;

class Phone {
    final String code;
    final String countryCode;
    final String countryName;

    Phone({
        required this.code,
        required this.countryCode,
        required this.countryName,
    });

    factory Phone.fromMap(Map<String, dynamic> map) {
        return Phone(
            code: map['code'],
            countryCode: map['countryCode'],
            countryName: map['countryName'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "code": code,
            "countryCode": countryCode,
            "countryName": countryName,
        };
    }
}
