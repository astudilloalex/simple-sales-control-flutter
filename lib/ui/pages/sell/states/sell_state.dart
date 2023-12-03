import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/src/product/domain/product.dart';

class SellState {
  const SellState({
    this.customer,
    this.products = const [],
    this.total = 0.0,
  });

  final Customer? customer;
  final List<Product> products;
  final double total;

  SellState copyWith({
    Customer? customer,
    List<Product>? products,
    double? total,
  }) {
    return SellState(
      customer: customer ?? this.customer,
      products: products ?? this.products,
      total: total ?? this.total,
    );
  }
}
