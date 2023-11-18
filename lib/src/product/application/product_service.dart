import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/product/domain/i_product_repository.dart';
import 'package:sales_control/src/product/domain/product.dart';

class ProductService {
  const ProductService(this._repository);

  final IProductRepository _repository;

  Future<List<Product>> findAll(
    String companyId,
    int size, [
    Product? lastElement,
  ]) async {
    final DefaultResponse response = await _repository.findAll(
      companyId,
      size,
      lastElement,
    );
    return (response.data as List<dynamic>)
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
