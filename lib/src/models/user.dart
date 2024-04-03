part of appwrite.models;

/// User
class User implements Model {
  /// User ID.
  final String? $id;

  /// User creation date in ISO 8601 format.
  final String? $createdAt;

  /// User update date in ISO 8601 format.
  final String? $updatedAt;

  /// User name.
  final String? name;

  /// Hashed user password.
  final String? password;

  /// Password hashing algorithm.
  final String? hash;

  /// Password hashing algorithm configuration.
  final Map? hashOptions;

  /// User registration date in ISO 8601 format.
  final String? registration;

  /// User status. Pass `true` for enabled and `false` for disabled.
  final bool status;

  /// Labels for the user.
  final List? labels;

  /// Password update time in ISO 8601 format.
  final String? passwordUpdate;

  /// User email address.
  final String? email;

  /// User phone number in E.164 format.
  final String? phone;

  /// Email verification status.
  final bool emailVerification;

  /// Phone verification status.
  final bool phoneVerification;

  /// Multi factor authentication status.
  final bool mfa;

  /// User preferences as a key-value object
  final Preferences? prefs;

  /// A user-owned message receiver. A single user may have multiple e.g. emails, phones, and a browser. Each target is registered with a single provider.
  final List<Target>? targets;

  /// Most recent access date in ISO 8601 format. This attribute is only updated again after 24 hours.
  final String? accessedAt;

  User({
    this.$id,
    this.$createdAt,
    this.$updatedAt,
    this.name,
    this.password,
    this.hash,
    this.hashOptions,
    this.registration,
    this.status = false,
    this.labels,
    this.passwordUpdate,
    this.email,
    this.phone,
    this.emailVerification = false,
    this.phoneVerification = false,
    this.mfa = false,
    this.prefs,
    this.targets,
    this.accessedAt,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      $id: map[r'$id'],
      $createdAt: map[r'$createdAt'],
      $updatedAt: map[r'$updatedAt'],
      name: map['name'],
      password: map['password'],
      hash: map['hash'],
      hashOptions: map['hashOptions'],
      registration: map['registration'],
      status: map['status'],
      labels: map['labels'],
      passwordUpdate: map['passwordUpdate'],
      email: map['email'],
      phone: map['phone'],
      emailVerification: map['emailVerification'],
      phoneVerification: map['phoneVerification'],
      mfa: map['mfa'],
      prefs: map['prefs'] != null ? Preferences.fromMap(map['prefs']) : null,
      targets: map['targets'] is List
          ? List<Target>.from(
              map['targets']?.map((p) => Target.fromMap(p))?.toList() ?? [],
            )
          : [],
      accessedAt: map['accessedAt'],
    );
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $createdAt.hashCode ^
        $updatedAt.hashCode ^
        name.hashCode ^
        password.hashCode ^
        hash.hashCode ^
        hashOptions.hashCode ^
        registration.hashCode ^
        status.hashCode ^
        labels.hashCode ^
        passwordUpdate.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        emailVerification.hashCode ^
        phoneVerification.hashCode ^
        mfa.hashCode ^
        prefs.hashCode ^
        targets.hashCode ^
        accessedAt.hashCode;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          $id == other.$id &&
          $createdAt == other.$createdAt &&
          $updatedAt == other.$updatedAt &&
          name == other.name &&
          password == other.password &&
          hash == other.hash &&
          hashOptions == other.hashOptions &&
          registration == other.registration &&
          status == other.status &&
          labels == other.labels &&
          passwordUpdate == other.passwordUpdate &&
          email == other.email &&
          phone == other.phone &&
          emailVerification == other.emailVerification &&
          phoneVerification == other.phoneVerification &&
          mfa == other.mfa &&
          prefs == other.prefs &&
          targets == other.targets &&
          accessedAt == other.accessedAt;

  User copyWith({
    String? $id,
    String? $createdAt,
    String? $updatedAt,
    String? name,
    String? password,
    String? hash,
    Map? hashOptions,
    String? registration,
    bool? status,
    List? labels,
    String? passwordUpdate,
    String? email,
    String? phone,
    bool? emailVerification,
    bool? phoneVerification,
    bool? mfa,
    Preferences? prefs,
    List<Target>? targets,
    String? accessedAt,
  }) {
    return User(
      $id: $id ?? this.$id,
      $createdAt: $createdAt ?? this.$createdAt,
      $updatedAt: $updatedAt ?? this.$updatedAt,
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
      mfa: mfa ?? this.mfa,
      prefs: prefs ?? this.prefs,
      targets: targets ?? this.targets,
      accessedAt: accessedAt ?? this.accessedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      r'$id': $id,
      r'$createdAt': $createdAt,
      r'$updatedAt': $updatedAt,
      'name': name,
      'password': password,
      'hash': hash,
      'hashOptions': hashOptions,
      'registration': registration,
      'status': status,
      'labels': labels,
      'passwordUpdate': passwordUpdate,
      'email': email,
      'phone': phone,
      'emailVerification': emailVerification,
      'phoneVerification': phoneVerification,
      'mfa': mfa,
      'prefs': prefs?.toMap(),
      'targets': targets?.map((p) => p.toMap()).toList(),
      'accessedAt': accessedAt,
    };
  }

  @override
  String toString() {
    return 'User{\$id: ${$id}, \$createdAt: ${$createdAt}, \$updatedAt: ${$updatedAt}, name: $name, password: $password, hash: $hash, hashOptions: $hashOptions, registration: $registration, status: $status, labels: $labels, passwordUpdate: $passwordUpdate, email: $email, phone: $phone, emailVerification: $emailVerification, phoneVerification: $phoneVerification, mfa: $mfa, prefs: $prefs, targets: $targets, accessedAt: $accessedAt}';
  }
}
