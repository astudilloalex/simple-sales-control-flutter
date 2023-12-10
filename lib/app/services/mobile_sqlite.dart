import 'package:path/path.dart';
import 'package:sales_control/app/services/i_sqlite.dart';
import 'package:sqflite/sqflite.dart';

class MobileSQLite implements ISQLite {
  const MobileSQLite._(this._database);

  final Database _database;

  static Future<MobileSQLite> getInstance(String path) async {
    final Database database = await openDatabase(
      join(path, 'localdatabase.db'),
      version: 1,
      onCreate: (db, version) async {
        final List<String> sqlList = createSQLV1.split(';');
        final Batch batch = db.batch();
        for (final String sql in sqlList) {
          batch.execute(sql.trim());
        }
        await batch.commit();
      },
      onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
    );
    return MobileSQLite._(database);
  }

  @override
  // TODO: implement database
  Database get database => _database;
}
