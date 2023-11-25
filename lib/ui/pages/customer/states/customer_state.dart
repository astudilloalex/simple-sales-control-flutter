import 'package:sales_control/src/customer/domain/customer.dart';

class CustomerState {
  const CustomerState({
    this.loading = false,
    this.loadingError = '',
    this.customers = const [],
  });

  final bool loading;
  final String loadingError;
  final List<Customer> customers;

  CustomerState copyWith({
    bool? loading,
    String? loadingError,
    List<Customer>? customers,
  }) {
    return CustomerState(
      loading: loading ?? this.loading,
      loadingError: loadingError ?? this.loadingError,
      customers: customers ?? this.customers,
    );
  }
}
