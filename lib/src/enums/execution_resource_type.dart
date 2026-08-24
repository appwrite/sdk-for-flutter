part of '../../enums.dart';

enum ExecutionResourceType {
  functions(value: "functions"),
  sites(value: "sites");

  const ExecutionResourceType({required this.value});

  final String value;

  String toJson() => value;
}
