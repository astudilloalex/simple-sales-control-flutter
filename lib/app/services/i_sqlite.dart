import 'package:sqflite/sqflite.dart';

abstract class ISQLite {
  const ISQLite();

  Database get database;
}
