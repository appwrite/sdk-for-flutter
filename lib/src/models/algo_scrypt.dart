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
            costCpu: (map['costCpu'] is String) ?
                        int.tryParse(map['costCpu']) ?? 0:map['costCpu'] ?? 0,
            costMemory: (map['costMemory'] is String) ?
                        int.tryParse(map['costMemory']) ?? 0:map['costMemory'] ?? 0,
            costParallel: (map['costParallel'] is String) ?
                        int.tryParse(map['costParallel']) ?? 0:map['costParallel'] ?? 0,
            length: (map['length'] is String) ?
                        int.tryParse(map['length']) ?? 0:map['length'] ?? 0,
        );
    }

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
