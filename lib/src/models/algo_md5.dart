part of '../../models.dart';

/// AlgoMD5
class AlgoMd5 implements Model {
  /// Algo type.
  final String type;

  AlgoMd5({
    required this.type,
  });

  factory AlgoMd5.fromMap(Map<String, dynamic> map) {
    return AlgoMd5(
      type: map['type'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "type": type,
    };
  }
}
