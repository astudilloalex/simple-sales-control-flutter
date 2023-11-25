import 'package:sales_control/src/customer/domain/customer.dart';

class EditCustomerState {
  const EditCustomerState({
    this.customer,
  });

  final Customer? customer;

  EditCustomerState copyWith({
    Customer? customer,
  }) {
    return EditCustomerState(
      customer: customer ?? this.customer,
    );
  }
}
