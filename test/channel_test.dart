import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('database()', () {
    test('returns database channel with defaults', () {
      expect(Channel.database().collection().document().toString(),
          'databases.*.collections.*.documents.*');
    });

    test('returns database channel with specific IDs', () {
      expect(
          Channel.database('db1')
              .collection('col1')
              .document('doc1')
              .toString(),
          'databases.db1.collections.col1.documents.doc1');
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
  });

  group('tablesdb()', () {
    test('returns tablesdb channel with defaults', () {
      expect(Channel.tablesdb().table().row().toString(),
          'tablesdb.*.tables.*.rows.*');
    });

    test('returns tablesdb channel with specific IDs', () {
      expect(Channel.tablesdb('db1').table('table1').row('row1').toString(),
          'tablesdb.db1.tables.table1.rows.row1');
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
    test('returns account channel with default', () {
      expect(Channel.account(), 'account.*');
    });

    test('returns account channel with specific user ID', () {
      expect(Channel.account('user123'), 'account.user123');
    });
  });

  group('bucket()', () {
    test('returns buckets channel with defaults', () {
      expect(Channel.bucket().file().toString(), 'buckets.*.files.*');
    });

    test('returns buckets channel with specific IDs', () {
      expect(Channel.bucket('bucket1').file('file1').toString(),
          'buckets.bucket1.files.file1');
    });

    test('returns buckets channel with action', () {
      expect(Channel.bucket('bucket1').file('file1').delete().toString(),
          'buckets.bucket1.files.file1.delete');
    });
  });

  group('functions()', () {
    test('returns functions channel with defaults', () {
      expect(Channel.function().execution().toString(),
          'functions.*.executions.*');
    });

    test('returns functions channel with specific IDs', () {
      expect(Channel.function('func1').execution('exec1').toString(),
          'functions.func1.executions.exec1');
    });

    test('returns functions channel with action', () {
      expect(Channel.function('func1').execution('exec1').create().toString(),
          'functions.func1.executions.exec1.create');
    });
  });

  group('teams()', () {
    test('returns teams channel with default', () {
      expect(Channel.team().toString(), 'teams.*');
    });

    test('returns teams channel with specific team ID', () {
      expect(Channel.team('team1').toString(), 'teams.team1');
    });

    test('returns teams channel with action', () {
      expect(Channel.team('team1').create().toString(), 'teams.team1.create');
    });
  });

  group('memberships()', () {
    test('returns memberships channel with default', () {
      expect(Channel.membership().toString(), 'memberships.*');
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
