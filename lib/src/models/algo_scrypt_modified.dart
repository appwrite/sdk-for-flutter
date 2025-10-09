part of '../../models.dart';

/// AlgoScryptModified
class AlgoScryptModified implements Model {
  /// Algo type.
  final String type;

  /// Salt used to compute hash.
  final String salt;

  /// Separator used to compute hash.
  final String saltSeparator;

  /// Key used to compute hash.
  final String signerKey;

  AlgoScryptModified({
    required this.type,
    required this.salt,
    required this.saltSeparator,
    required this.signerKey,
  });

  factory AlgoScryptModified.fromMap(Map<String, dynamic> map) {
    return AlgoScryptModified(
      type: map['type'].toString(),
      salt: map['salt'].toString(),
      saltSeparator: map['saltSeparator'].toString(),
      signerKey: map['signerKey'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "salt": salt,
      "saltSeparator": saltSeparator,
      "signerKey": signerKey,
    };
  }
}
