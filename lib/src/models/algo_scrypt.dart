part of '../../models.dart';

/// AlgoScrypt
class AlgoScrypt implements Model {
  /// Algo type.
  final String type;

  /// CPU complexity of computed hash.
  final int costCpu;

  /// Memory complexity of computed hash.
  final int costMemory;

  /// Parallelization of computed hash.
  final int costParallel;

  /// Length used to compute hash.
  final int length;

  AlgoScrypt({
    required this.type,
    required this.costCpu,
    required this.costMemory,
    required this.costParallel,
    required this.length,
  });

  factory AlgoScrypt.fromMap(Map<String, dynamic> map) {
    return AlgoScrypt(
      type: map['type'].toString(),
      costCpu: map['costCpu'],
      costMemory: map['costMemory'],
      costParallel: map['costParallel'],
      length: map['length'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "costCpu": costCpu,
      "costMemory": costMemory,
      "costParallel": costParallel,
      "length": length,
    };
  }
}
