import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/customer_search_history/domain/customer_search_history.dart';

abstract class ICustomerSearchHistoryRepository {
  const ICustomerSearchHistoryRepository();

  Future<DefaultResponse> findAll([int page = 1, int size = 10]);

  Future<DefaultResponse> saveOrUpdate(CustomerSearchHistory entity);
}
