part of appwrite.models;

class Phone {
    late final String code;
    late final String countryCode;
    late final String countryName;

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
