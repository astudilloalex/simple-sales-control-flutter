import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/src/customer/domain/i_customer_repository.dart';

class CustomerService {
  const CustomerService(this._repository);

  final ICustomerRepository _repository;

  Future<Customer> add(Customer customer) async {
    final DefaultResponse response = await _repository.save(customer);
    return Customer.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Customer> update(Customer customer) async {
    final DefaultResponse response = await _repository.update(customer);
    return Customer.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Customer?> getById(String companyId, String id) async {
    final DefaultResponse response = await _repository.findById(companyId, id);
    if (response.data == null) return null;
    return Customer.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<Customer>> findAll(
    String companyId,
    int size, [
    Customer? lastElement,
  ]) async {
    final DefaultResponse response = await _repository.findAll(
      companyId,
      size,
      lastElement,
    );
    return (response.data as List<dynamic>)
        .map((json) => Customer.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> delete(String companyId, String id) async {
    await _repository.delete(companyId, id);
  }

  Future<List<Customer>> getByIdCardOrKeyword(
    String companyId,
    String value,
  ) async {
    final bool isIdCard = RegExp(r'\d').hasMatch(value);
    final DefaultResponse response = isIdCard
        ? await _repository.findByIdCard(companyId, value)
        : await _repository.findByKeyword(companyId, value.toUpperCase());
    return (response.data as List<dynamic>)
        .map((json) => Customer.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
