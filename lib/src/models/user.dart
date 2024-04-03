part of appwrite.models;

class HashOptions {
  final String? type;
  final int? memoryCost;
  final int? timeCost;
  final int? threads;

  HashOptions({
    this.type,
    this.memoryCost,
    this.timeCost,
    this.threads,
  });

  factory HashOptions.fromMap(Map<String, dynamic> json) => HashOptions(
        type: json["type"],
        memoryCost: json["memoryCost"],
        timeCost: json["timeCost"],
        threads: json["threads"],
      );

  HashOptions copyWith({
    String? type,
    int? memoryCost,
    int? timeCost,
    int? threads,
  }) =>
      HashOptions(
        type: type ?? this.type,
        memoryCost: memoryCost ?? this.memoryCost,
        timeCost: timeCost ?? this.timeCost,
        threads: threads ?? this.threads,
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "memoryCost": memoryCost,
        "timeCost": timeCost,
        "threads": threads,
      };
}

class User {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? password;
  final String? hash;
  final HashOptions? hashOptions;
  final DateTime? registration;
  final bool? status;
  final List<String>? labels;
  final DateTime? passwordUpdate;
  final String? email;
  final String? phone;
  final bool? emailVerification;
  final bool? phoneVerification;
  final Preferences? prefs;
  final DateTime? accessedAt;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.password,
    this.hash,
    this.hashOptions,
    this.registration,
    this.status,
    this.labels,
    this.passwordUpdate,
    this.email,
    this.phone,
    this.emailVerification,
    this.phoneVerification,
    this.prefs,
    this.accessedAt,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["\u0024id"],
        createdAt: json["\u0024createdAt"] == null
            ? null
            : DateTime.parse(json["\u0024createdAt"]),
        updatedAt: json["\u0024updatedAt"] == null
            ? null
            : DateTime.parse(json["\u0024updatedAt"]),
        name: json["name"],
        password: json["password"],
        hash: json["hash"],
        hashOptions: json["hashOptions"] == null
            ? null
            : HashOptions.fromMap(json["hashOptions"]),
        registration: json["registration"] == null
            ? null
            : DateTime.parse(json["registration"]),
        status: json["status"],
        labels: json["labels"] == null
            ? []
            : List<String>.from(json["labels"]!.map((x) => x)),
        passwordUpdate: json["passwordUpdate"] == null
            ? null
            : DateTime.parse(json["passwordUpdate"]),
        email: json["email"],
        phone: json["phone"],
        emailVerification: json["emailVerification"],
        phoneVerification: json["phoneVerification"],
        prefs:
            json["prefs"] == null ? null : Preferences.fromMap(json["prefs"]),
        accessedAt: json["accessedAt"] == null
            ? null
            : DateTime.parse(json["accessedAt"]),
      );

  User copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? password,
    String? hash,
    HashOptions? hashOptions,
    DateTime? registration,
    bool? status,
    List<String>? labels,
    DateTime? passwordUpdate,
    String? email,
    String? phone,
    bool? emailVerification,
    bool? phoneVerification,
    Preferences? prefs,
    DateTime? accessedAt,
  }) =>
      User(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        password: password ?? this.password,
        hash: hash ?? this.hash,
        hashOptions: hashOptions ?? this.hashOptions,
        registration: registration ?? this.registration,
        status: status ?? this.status,
        labels: labels ?? this.labels,
        passwordUpdate: passwordUpdate ?? this.passwordUpdate,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        emailVerification: emailVerification ?? this.emailVerification,
        phoneVerification: phoneVerification ?? this.phoneVerification,
        prefs: prefs ?? this.prefs,
        accessedAt: accessedAt ?? this.accessedAt,
      );

  Map<String, dynamic> toMap() => {
        "\u0024id": id,
        "\u0024createdAt": createdAt?.toIso8601String(),
        "\u0024updatedAt": updatedAt?.toIso8601String(),
        "name": name,
        "password": password,
        "hash": hash,
        "hashOptions": hashOptions?.toMap(),
        "registration": registration?.toIso8601String(),
        "status": status,
        "labels":
            labels == null ? [] : List<dynamic>.from(labels!.map((x) => x)),
        "passwordUpdate": passwordUpdate?.toIso8601String(),
        "email": email,
        "phone": phone,
        "emailVerification": emailVerification,
        "phoneVerification": phoneVerification,
        "prefs": prefs?.toMap(),
        "accessedAt": accessedAt?.toIso8601String(),
      };
}
