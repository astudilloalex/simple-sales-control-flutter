import 'package:sqflite/sqflite.dart';

abstract class ISQLite {
  const ISQLite();

  Database get database;
}

const String createSQLV1 = '''
CREATE TABLE customer_search_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  value TEXT NOT NULL,
  date DATETIME NOT NULL
);

CREATE TABLE product_search_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  value TEXT NOT NULL,
  date DATETIME NOT NULL
);
''';
