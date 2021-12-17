part of appwrite.models;

/// Sessions List
class SessionList implements Model {
    /// Total number of items available on the server.
    final int sum;
    /// List of sessions.
    final List<Session> sessions;

    SessionList({
        required this.sum,
        required this.sessions,
    });

    factory SessionList.fromMap(Map<String, dynamic> map) {
        return SessionList(
            sum: map['sum'],
            sessions: List<Session>.from(map['sessions'].map((p) => Session.fromMap(p))),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "sessions": sessions.map((p) => p.toMap()),
        };
    }
}
