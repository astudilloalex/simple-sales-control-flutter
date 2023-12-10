import 'package:sales_control/app/services/i_sqlite.dart';
import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/product_search_history/domain/i_product_search_history_repository.dart';
import 'package:sales_control/src/product_search_history/domain/product_search_history.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteProductSearchHistory implements IProductSearchHistoryRepository {
  const SQLiteProductSearchHistory(this._sqlite);

  final ISQLite _sqlite;

  @override
  Future<DefaultResponse> findAll([int page = 1, int size = 10]) async {
    final List<Map<String, dynamic>> data = await _sqlite.database.query(
      'product_search_history',
      offset: page - 1,
      limit: size,
      orderBy: 'date DESC',
    );
    return DefaultResponse(data: data);
  }

  @override
  Future<DefaultResponse> saveOrUpdate(ProductSearchHistory entity) async {
    final Database db = _sqlite.database;
    final List<Map<String, dynamic>> data = await db.query(
      'product_search_history',
      where: 'value = ?',
      whereArgs: [entity.value],
    );
    if (data.isEmpty) {
      final Map<String, dynamic> json = entity.toJson();
      json.removeWhere((key, value) => key == 'id');
      return DefaultResponse(
        data: entity
            .copyWith(
              id: await db.insert(
                'product_search_history',
                json,
              ),
            )
            .toJson(),
      );
    } else {
      final ProductSearchHistory finded = ProductSearchHistory.fromJson(
        data.first,
      );
      final Map<String, dynamic> json = entity.toJson();
      json.removeWhere((key, value) => key == 'id');
      await db.update(
        'product_search_history',
        json,
        where: 'id = ?',
        whereArgs: [finded.id],
      );
      return DefaultResponse(data: entity.copyWith(id: finded.id).toJson());
    }
  }
}
