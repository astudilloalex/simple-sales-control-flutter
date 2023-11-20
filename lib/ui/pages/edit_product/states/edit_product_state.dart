import 'package:sales_control/src/product/domain/product.dart';

class EditProductState {
  const EditProductState({
    this.loading = false,
    this.product,
  });

  final bool loading;
  final Product? product;

  EditProductState copyWith({
    bool? loading,
    Product? product,
  }) {
    return EditProductState(
      loading: loading ?? this.loading,
      product: product ?? this.product,
    );
  }
}
