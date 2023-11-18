import 'package:sales_control/src/product/domain/product.dart';

class ProductState {
  const ProductState({
    this.products = const [],
    this.loading = false,
    this.loadingError = '',
  });

  final List<Product> products;
  final bool loading;
  final String loadingError;

  ProductState copyWith({
    List<Product>? products,
    bool? loading,
    String? loadingError,
  }) {
    return ProductState(
      loading: loading ?? this.loading,
      products: products ?? this.products,
      loadingError: loadingError ?? this.loadingError,
    );
  }
}
