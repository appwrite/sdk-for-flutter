part of appwrite.models;

class Execution {
    final String $id;
    final Permissions $permissions;
    final String functionId;
    final int dateCreated;
    final String trigger;
    final String status;
    final int exitCode;
    final String stdout;
    final String stderr;
    final double time;

    Execution({
        required this.$id,
        required this.$permissions,
        required this.functionId,
        required this.dateCreated,
        required this.trigger,
        required this.status,
        required this.exitCode,
        required this.stdout,
        required this.stderr,
        required this.time,
    });

    factory Execution.fromMap(Map<String, dynamic> map) {
        return Execution(
            $id: map['\$id'],
            $permissions: Permissions.fromMap(map['\$permissions']),
            functionId: map['functionId'],
            dateCreated: map['dateCreated'],
            trigger: map['trigger'],
            status: map['status'],
            exitCode: map['exitCode'],
            stdout: map['stdout'],
            stderr: map['stderr'],
            time: map['time'].toDouble(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$permissions": $permissions.toMap(),
            "functionId": functionId,
            "dateCreated": dateCreated,
            "trigger": trigger,
            "status": status,
            "exitCode": exitCode,
            "stdout": stdout,
            "stderr": stderr,
            "time": time,
        };
    }
}
