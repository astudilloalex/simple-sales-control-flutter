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
        if (version == 1) {
          await db.execute(createSQLV1);
        }
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
