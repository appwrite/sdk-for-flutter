part of appwrite.models;

/// Execution
class Execution implements Model {
    /// Execution ID.
    final String $id;
    /// Execution read permissions.
    final List $read;
    /// Function ID.
    final String functionId;
    /// The execution creation date in Unix timestamp.
    final int dateCreated;
    /// The trigger that caused the function to execute. Possible values can be: `http`, `schedule`, or `event`.
    final String trigger;
    /// The status of the function execution. Possible values can be: `waiting`, `processing`, `completed`, or `failed`.
    final String status;
    /// The script exit code.
    final int exitCode;
    /// The script stdout output string. Logs the last 4,000 characters of the execution stdout output.
    final String stdout;
    /// The script stderr output string. Logs the last 4,000 characters of the execution stderr output
    final String stderr;
    /// The script execution time in seconds.
    final double time;

    Execution({
        required this.$id,
        required this.$read,
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
            $read: map['\$read'],
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

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$read": $read,
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
