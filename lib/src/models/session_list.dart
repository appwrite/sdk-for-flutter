part of '../../models.dart';

/// Sessions List
class SessionList implements Model {
    /// Total number of sessions documents that matched your query.
    final int total;
    /// List of sessions.
    final List<Session> sessions;

    SessionList({
        required this.total,
        required this.sessions,
    });

    factory SessionList.fromMap(Map<String, dynamic> map) {
        return SessionList(
            total: (map['total'] is String) ?
                        int.tryParse(map['total']) ?? 0:map['total'] ?? 0,
            sessions: List<Session>.from(map['sessions'].map((p) => Session.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "sessions": sessions.map((p) => p.toMap()).toList(),
        };
    }
}
