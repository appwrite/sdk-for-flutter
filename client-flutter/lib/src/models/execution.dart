part of appwrite.models;

/// Execution
class Execution implements Model {
    /// Execution ID.
    final String $id;
    /// Execution creation date in Unix timestamp.
    final int $createdAt;
    /// Execution update date in Unix timestamp.
    final int $updatedAt;
    /// Execution read permissions.
    final List $read;
    /// Function ID.
    final String functionId;
    /// The trigger that caused the function to execute. Possible values can be: `http`, `schedule`, or `event`.
    final String trigger;
    /// The status of the function execution. Possible values can be: `waiting`, `processing`, `completed`, or `failed`.
    final String status;
    /// The script status code.
    final int statusCode;
    /// The script response output string. Logs the last 4,000 characters of the execution response output.
    final String response;
    /// The script stderr output string. Logs the last 4,000 characters of the execution stderr output
    final String stderr;
    /// The script execution time in seconds.
    final double time;

    Execution({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.$read,
        required this.functionId,
        required this.trigger,
        required this.status,
        required this.statusCode,
        required this.response,
        required this.stderr,
        required this.time,
    });

    factory Execution.fromMap(Map<String, dynamic> map) {
        return Execution(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'],
            $updatedAt: map['\$updatedAt'],
            $read: map['\$read'],
            functionId: map['functionId'].toString(),
            trigger: map['trigger'].toString(),
            status: map['status'].toString(),
            statusCode: map['statusCode'],
            response: map['response'].toString(),
            stderr: map['stderr'].toString(),
            time: map['time'].toDouble(),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "\$read": $read,
            "functionId": functionId,
            "trigger": trigger,
            "status": status,
            "statusCode": statusCode,
            "response": response,
            "stderr": stderr,
            "time": time,
        };
    }
}
