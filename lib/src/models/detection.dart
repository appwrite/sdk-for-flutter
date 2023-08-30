part of appwrite.models;

/// Detection
class Detection implements Model {
    /// Runtime
    final String runtime;

    Detection({
        required this.runtime,
    });

    factory Detection.fromMap(Map<String, dynamic> map) {
        return Detection(
            runtime: map['runtime'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "runtime": runtime,
        };
    }
}
