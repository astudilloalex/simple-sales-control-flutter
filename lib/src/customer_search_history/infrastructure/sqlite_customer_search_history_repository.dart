import 'package:sales_control/app/services/i_sqlite.dart';
import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/customer_search_history/domain/customer_search_history.dart';
import 'package:sales_control/src/customer_search_history/domain/i_customer_search_history_repository.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteCustomerSearchHistoryRepository
    implements ICustomerSearchHistoryRepository {
  const SQLiteCustomerSearchHistoryRepository(this._sqlite);

  final ISQLite _sqlite;

  @override
  Future<DefaultResponse> findAll([int page = 1, int size = 10]) async {
    final List<Map<String, dynamic>> data = await _sqlite.database.query(
      'customer_search_history',
      offset: page - 1,
      limit: size,
      orderBy: 'date DESC',
    );
    return DefaultResponse(data: data);
  }

  @override
  Future<DefaultResponse> saveOrUpdate(CustomerSearchHistory entity) async {
    final Database db = _sqlite.database;
    final List<Map<String, dynamic>> data = await db.query(
      'customer_search_history',
      where: 'value = ?',
      whereArgs: [entity.value],
    );
    if (data.isEmpty) {
      return DefaultResponse(
        data: entity.copyWith(
          id: await db.insert(
            'customer_search_history',
            entity.toJson(),
          ),
        ),
      );
    } else {
      final CustomerSearchHistory finded = CustomerSearchHistory.fromJson(
        data.first,
      );
      await db.update(
        'customer_search_history',
        entity.toJson(),
        where: 'id = ?',
        whereArgs: [finded.id],
      );
      return DefaultResponse(data: entity.copyWith(id: finded.id));
    }
  }
}
