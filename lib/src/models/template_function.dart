part of '../../models.dart';

/// Template Function
class TemplateFunction implements Model {
  /// Function Template Icon.
  final String icon;

  /// Function Template ID.
  final String id;

  /// Function Template Name.
  final String name;

  /// Function Template Tagline.
  final String tagline;

  /// Execution permissions.
  final List permissions;

  /// Function trigger events.
  final List events;

  /// Function execution schedult in CRON format.
  final String cron;

  /// Function execution timeout in seconds.
  final int timeout;

  /// Function use cases.
  final List useCases;

  /// List of runtimes that can be used with this template.
  final List<TemplateRuntime> runtimes;

  /// Function Template Instructions.
  final String instructions;

  /// VCS (Version Control System) Provider.
  final String vcsProvider;

  /// VCS (Version Control System) Repository ID
  final String providerRepositoryId;

  /// VCS (Version Control System) Owner.
  final String providerOwner;

  /// VCS (Version Control System) branch version (tag).
  final String providerVersion;

  /// Function variables.
  final List<TemplateVariable> variables;

  /// Function scopes.
  final List scopes;

  TemplateFunction({
    required this.icon,
    required this.id,
    required this.name,
    required this.tagline,
    required this.permissions,
    required this.events,
    required this.cron,
    required this.timeout,
    required this.useCases,
    required this.runtimes,
    required this.instructions,
    required this.vcsProvider,
    required this.providerRepositoryId,
    required this.providerOwner,
    required this.providerVersion,
    required this.variables,
    required this.scopes,
  });

  factory TemplateFunction.fromMap(Map<String, dynamic> map) {
    return TemplateFunction(
      icon: map['icon'].toString(),
      id: map['id'].toString(),
      name: map['name'].toString(),
      tagline: map['tagline'].toString(),
      permissions: map['permissions'] ?? [],
      events: map['events'] ?? [],
      cron: map['cron'].toString(),
      timeout: map['timeout'],
      useCases: map['useCases'] ?? [],
      runtimes: List<TemplateRuntime>.from(
          map['runtimes'].map((p) => TemplateRuntime.fromMap(p))),
      instructions: map['instructions'].toString(),
      vcsProvider: map['vcsProvider'].toString(),
      providerRepositoryId: map['providerRepositoryId'].toString(),
      providerOwner: map['providerOwner'].toString(),
      providerVersion: map['providerVersion'].toString(),
      variables: List<TemplateVariable>.from(
          map['variables'].map((p) => TemplateVariable.fromMap(p))),
      scopes: map['scopes'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "icon": icon,
      "id": id,
      "name": name,
      "tagline": tagline,
      "permissions": permissions,
      "events": events,
      "cron": cron,
      "timeout": timeout,
      "useCases": useCases,
      "runtimes": runtimes.map((p) => p.toMap()).toList(),
      "instructions": instructions,
      "vcsProvider": vcsProvider,
      "providerRepositoryId": providerRepositoryId,
      "providerOwner": providerOwner,
      "providerVersion": providerVersion,
      "variables": variables.map((p) => p.toMap()).toList(),
      "scopes": scopes,
    };
  }
}
