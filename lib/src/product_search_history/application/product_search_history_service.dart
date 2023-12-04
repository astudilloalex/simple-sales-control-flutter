import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/product_search_history/domain/i_product_search_history_repository.dart';
import 'package:sales_control/src/product_search_history/domain/product_search_history.dart';

class ProductSearchHistoryService {
  const ProductSearchHistoryService(this._repository);

  final IProductSearchHistoryRepository _repository;

  Future<List<ProductSearchHistory>> getAll([
    int page = 1,
    int size = 10,
  ]) async {
    final DefaultResponse response = await _repository.findAll(page, size);
    return (response.data as List<dynamic>)
        .map(
          (json) => ProductSearchHistory.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Future<ProductSearchHistory> addOrUpdate(
    ProductSearchHistory customerSearchHistory,
  ) async {
    final DefaultResponse response = await _repository.saveOrUpdate(
      customerSearchHistory,
    );
    return ProductSearchHistory.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
