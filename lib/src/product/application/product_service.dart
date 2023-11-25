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

  Future<Product> save(Product product) async {
    final DefaultResponse response = await _repository.save(
      product.companyId,
      product,
    );
    return Product.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Product> update(Product product) async {
    final DefaultResponse response = await _repository.update(
      product.companyId,
      product,
    );
    return Product.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Product?> getById(String companyId, String id) async {
    final DefaultResponse response = await _repository.findById(companyId, id);
    return Product.fromJson(response.data as Map<String, dynamic>);
  }

  Future<double> replenish(
    String companyId,
    String id, [
    double quantity = 0.0,
  ]) async {
    final DefaultResponse response =
        await _repository.addInventory(companyId, id, quantity);
    return response.data as double;
  }
}
