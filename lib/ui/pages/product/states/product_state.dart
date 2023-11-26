import 'package:sales_control/src/product/domain/product.dart';

class ProductState {
  const ProductState({
    this.products = const [],
    this.loading = false,
    this.loadingPagination = false,
    this.loadingError = '',
  });

  final List<Product> products;
  final bool loading;
  final bool loadingPagination;
  final String loadingError;

  ProductState copyWith({
    List<Product>? products,
    bool? loading,
    bool? loadingPagination,
    String? loadingError,
  }) {
    return ProductState(
      loading: loading ?? this.loading,
      loadingPagination: loadingPagination ?? this.loadingPagination,
      products: products ?? this.products,
      loadingError: loadingError ?? this.loadingError,
    );
  }
}
