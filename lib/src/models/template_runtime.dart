part of '../../models.dart';

/// Template Runtime
class TemplateRuntime implements Model {
  /// Runtime Name.
  final String name;

  /// The build command used to build the deployment.
  final String commands;

  /// The entrypoint file used to execute the deployment.
  final String entrypoint;

  /// Path to function in VCS (Version Control System) repository
  final String providerRootDirectory;

  TemplateRuntime({
    required this.name,
    required this.commands,
    required this.entrypoint,
    required this.providerRootDirectory,
  });

  factory TemplateRuntime.fromMap(Map<String, dynamic> map) {
    return TemplateRuntime(
      name: map['name'].toString(),
      commands: map['commands'].toString(),
      entrypoint: map['entrypoint'].toString(),
      providerRootDirectory: map['providerRootDirectory'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "commands": commands,
      "entrypoint": entrypoint,
      "providerRootDirectory": providerRootDirectory,
    };
  }
}
