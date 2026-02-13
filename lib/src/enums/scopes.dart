part of '../../enums.dart';

enum Scopes {
    account(value: 'account'),
    teamsRead(value: 'teams.read'),
    teamsWrite(value: 'teams.write');

    const Scopes({
        required this.value
    });

    final String value;

    String toJson() => value;
}