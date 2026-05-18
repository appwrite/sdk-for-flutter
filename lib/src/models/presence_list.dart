part of '../../models.dart';

/// Presences List
class PresenceList implements Model {
    /// Total number of presences that matched your query.
    final int total;

    /// List of presences.
    final List<Presence> presences;

    PresenceList({
        required this.total,
        required this.presences,
    });

    factory PresenceList.fromMap(Map<String, dynamic> map) {
        return PresenceList(
            total: map['total'],
            presences: List<Presence>.from(map['presences'].map((p) => Presence.fromMap(p))),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "presences": presences.map((p) => p.toMap()).toList(),
        };
    }

    List<T> convertTo<T>(T Function(Map) fromJson) =>
        presences.map((d) => d.convertTo<T>(fromJson)).toList();
}
