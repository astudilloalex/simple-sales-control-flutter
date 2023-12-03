import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/customer_search_history/domain/customer_search_history.dart';
import 'package:sales_control/src/customer_search_history/domain/i_customer_search_history_repository.dart';

class CustomerSearchHistoryService {
  const CustomerSearchHistoryService(this._repository);

  final ICustomerSearchHistoryRepository _repository;

  Future<List<CustomerSearchHistory>> getAll([
    int page = 1,
    int size = 10,
  ]) async {
    final DefaultResponse response = await _repository.findAll(page, size);
    return (response.data as List<dynamic>)
        .map(
          (json) =>
              CustomerSearchHistory.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Future<CustomerSearchHistory> addOrUpdate(
    CustomerSearchHistory customerSearchHistory,
  ) async {
    final DefaultResponse response = await _repository.saveOrUpdate(
      customerSearchHistory,
    );
    return CustomerSearchHistory.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
