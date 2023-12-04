import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/product_search_history/domain/product_search_history.dart';

abstract class IProductSearchHistoryRepository {
  const IProductSearchHistoryRepository();

  Future<DefaultResponse> findAll([int page = 1, int size = 10]);
  Future<DefaultResponse> saveOrUpdate(ProductSearchHistory entity);
}
