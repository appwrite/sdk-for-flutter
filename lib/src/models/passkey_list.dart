part of '../../models.dart';

/// Passkeys List
class PasskeyList implements Model {
  /// Total number of passkeys that matched your query.
  final int total;

  /// List of passkeys.
  final List<Passkey> passkeys;

  PasskeyList({
    required this.total,
    required this.passkeys,
  });
  factory PasskeyList.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      'total': 0,
      'passkeys': [],
      ...map,
    };

    return PasskeyList(
      total: map['total'],
      passkeys: List<Passkey>.from(
        map['passkeys'].map((p) => Passkey.fromMap(p)),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "passkeys": passkeys.map((p) => p.toMap()).toList(),
    };
  }
}
