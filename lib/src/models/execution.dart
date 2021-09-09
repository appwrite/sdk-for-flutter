part of appwrite.models;

class Execution {
    late final String $id;
    late final String functionId;
    late final int dateCreated;
    late final String trigger;
    late final String status;
    late final int exitCode;
    late final String stdout;
    late final String stderr;
    late final double time;

    Execution({
        required this.$id,
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
