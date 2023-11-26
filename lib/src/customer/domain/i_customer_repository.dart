import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/customer/domain/customer.dart';

abstract class ICustomerRepository {
  const ICustomerRepository();

  Future<DefaultResponse> save(Customer customer);
  Future<DefaultResponse> update(Customer customer);
  Future<DefaultResponse> findAll(
    String companyId,
    int size, [
    Customer? lastElement,
  ]);
  Future<DefaultResponse> findById(String companyId, String id);
  Future<DefaultResponse> delete(String companyId, String id);
}
