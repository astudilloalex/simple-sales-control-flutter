import 'package:sales_control/src/customer/domain/customer.dart';

class CustomerState {
  const CustomerState({
    this.loading = false,
    this.loadingError = '',
    this.loadingPagination = false,
    this.customers = const [],
  });

  final bool loading;
  final String loadingError;
  final bool loadingPagination;
  final List<Customer> customers;

  CustomerState copyWith({
    bool? loading,
    bool? loadingPagination,
    String? loadingError,
    List<Customer>? customers,
  }) {
    return CustomerState(
      loading: loading ?? this.loading,
      loadingPagination: loadingPagination ?? this.loadingPagination,
      loadingError: loadingError ?? this.loadingError,
      customers: customers ?? this.customers,
    );
  }
}
