import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('database()', () {
    test('throws when database id is missing', () {
      expect(() => Channel.database(''), throwsArgumentError);
    });

    test('returns database channel with specific IDs', () {
      expect(Channel.database('db1').collection('col1').document().toString(),
          'databases.db1.collections.col1.documents');
    });

    test('returns database channel with action', () {
      expect(
          Channel.database('db1')
              .collection('col1')
              .document('doc1')
              .create()
              .toString(),
          'databases.db1.collections.col1.documents.doc1.create');
    });

    test('returns database channel with upsert action', () {
      expect(
          Channel.database('db1')
              .collection('col1')
              .document('doc1')
              .upsert()
              .toString(),
          'databases.db1.collections.col1.documents.doc1.upsert');
    });
  });

  group('tablesdb()', () {
    test('throws when tablesdb id is missing', () {
      expect(() => Channel.tablesdb(''), throwsArgumentError);
    });

    test('returns tablesdb channel with specific IDs', () {
      expect(Channel.tablesdb('db1').table('table1').row().toString(),
          'tablesdb.db1.tables.table1.rows');
    });

    test('returns tablesdb channel with action', () {
      expect(
          Channel.tablesdb('db1')
              .table('table1')
              .row('row1')
              .update()
              .toString(),
          'tablesdb.db1.tables.table1.rows.row1.update');
    });
  });

  group('account()', () {
    test('returns account channel', () {
      expect(Channel.account(), 'account');
    });
  });

  group('bucket()', () {
    test('throws when bucket id is missing', () {
      expect(() => Channel.bucket(''), throwsArgumentError);
    });

    test('returns buckets channel with specific IDs', () {
      expect(
          Channel.bucket('bucket1').file().toString(), 'buckets.bucket1.files');
    });

    test('returns buckets channel with action', () {
      expect(Channel.bucket('bucket1').file('file1').delete().toString(),
          'buckets.bucket1.files.file1.delete');
    });
  });

  group('functions()', () {
    test('throws when function id is missing', () {
      expect(() => Channel.function(''), throwsArgumentError);
    });

    test('returns functions channel with specific IDs', () {
      expect(Channel.function('func1').toString(), 'functions.func1');
    });
  });

  group('executions()', () {
    test('throws when execution id is missing', () {
      expect(() => Channel.execution(''), throwsArgumentError);
    });

    test('returns executions channel with specific IDs', () {
      expect(Channel.execution('exec1').toString(), 'executions.exec1');
    });
  });

  group('teams()', () {
    test('throws when team id is missing', () {
      expect(() => Channel.team(''), throwsArgumentError);
    });

    test('returns teams channel with specific team ID', () {
      expect(Channel.team('team1').toString(), 'teams.team1');
    });

    test('returns teams channel with action', () {
      expect(Channel.team('team1').create().toString(), 'teams.team1.create');
    });
  });

  group('memberships()', () {
    test('throws when membership id is missing', () {
      expect(() => Channel.membership(''), throwsArgumentError);
    });

    test('returns memberships channel with specific membership ID', () {
      expect(Channel.membership('membership1').toString(),
          'memberships.membership1');
    });

    test('returns memberships channel with action', () {
      expect(Channel.membership('membership1').update().toString(),
          'memberships.membership1.update');
    });
  });
}
