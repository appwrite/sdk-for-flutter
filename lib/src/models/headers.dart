part of '../../models.dart';

/// Headers
class Headers implements Model {
    /// Header name.
    final String name;

    /// Header value.
    final String value;

    Headers({
        required this.name,
        required this.value,
    });

    factory Headers.fromMap(Map<String, dynamic> map) {
        return Headers(
            name: map['name'].toString(),
            value: map['value'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "name": name,
            "value": value,
        };
    }
}
