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
            memoryCost: (map['memoryCost'] is String) ?
                        int.tryParse(map['memoryCost']) ?? 0:map['memoryCost'] ?? 0,
            timeCost: (map['timeCost'] is String) ?
                        int.tryParse(map['timeCost']) ?? 0:map['timeCost'] ?? 0,
            threads: (map['threads'] is String) ?
                        int.tryParse(map['threads']) ?? 0:map['threads'] ?? 0,
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "type": type,
            "memoryCost": memoryCost,
            "timeCost": timeCost,
            "threads": threads,
        };
    }
}
