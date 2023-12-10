import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/src/sale/domain/sale.dart';

class SellState {
  const SellState({
    this.customer,
    required this.sale,
  });

  final Customer? customer;
  final Sale sale;

  SellState copyWith({
    Customer? customer,
    Sale? sale,
  }) {
    return SellState(
      customer: customer ?? this.customer,
      sale: sale ?? this.sale,
    );
  }
}
