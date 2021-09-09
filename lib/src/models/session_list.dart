part of appwrite.models;

class SessionList {
    late final int sum;
    late final List<Session> sessions;

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

    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "sessions": sessions.map((p) => p.toMap()),
        };
    }

}
