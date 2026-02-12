part of '../../models.dart';

/// AlgoArgon2
class AlgoArgon2 implements Model {
  /// Algo type.
  final String type;

  /// Memory used to compute hash.
  final int memoryCost;

  /// Amount of time consumed to compute hash
  final int timeCost;

  /// Number of threads used to compute hash.
  final int threads;

  AlgoArgon2({
    required this.type,
    required this.memoryCost,
    required this.timeCost,
    required this.threads,
  });

  factory AlgoArgon2.fromMap(Map<String, dynamic> map) {
    return AlgoArgon2(
      type: map['type'].toString(),
      memoryCost: map['memoryCost'],
      timeCost: map['timeCost'],
      threads: map['threads'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "memoryCost": memoryCost,
      "timeCost": timeCost,
      "threads": threads,
    };
  }
}
