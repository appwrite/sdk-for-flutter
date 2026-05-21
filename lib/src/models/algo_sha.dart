part of '../../models.dart';

/// AlgoSHA
class AlgoSha implements Model {
  /// Algo type.
  final String type;

  AlgoSha({
    required this.type,
  });

  factory AlgoSha.fromMap(Map<String, dynamic> map) {
    return AlgoSha(
      type: map['type'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "type": type,
    };
  }
}
