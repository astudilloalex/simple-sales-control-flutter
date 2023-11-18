import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/product/domain/product.dart';

abstract class IProductRepository {
  const IProductRepository();

  Future<DefaultResponse> save(String companyId, Product product);

  Future<DefaultResponse> update(String companyId, Product product);

  Future<DefaultResponse> findAll(
    String companyId,
    int size, [
    Product? lastElement,
  ]);

  Future<DefaultResponse> findById(String companyId, String id);

  Future<DefaultResponse> addInventory(
    String companyId,
    String id,
    double quantity,
  );
}
