import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/product/application/product_service.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/ui/pages/product/states/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.service,
    required this.companyId,
  }) : super(const ProductState());

  final ProductService service;
  final String companyId;

  int pageSize = 100;

  Future<void> load() async {
    List<Product> data = [];
    String error = '';
    try {
      emit(state.copyWith(loading: true, loadingError: ''));
      final Product? last = state.products.isEmpty ? null : state.products.last;
      if (last == null) {
        data = await service.findAll(companyId, pageSize, last);
      } else {
        data = [
          ...state.products,
          ...await service.findAll(companyId, pageSize, last),
        ];
      }
    } on Exception {
      error = 'loading-error';
    } finally {
      emit(
        state.copyWith(
          loading: false,
          products: data,
          loadingError: error,
        ),
      );
    }
  }

  void addProduct(Product? product) {
    if (product == null) return;
    emit(state.copyWith(products: [...state.products, product]));
  }

  void updateProduct(Product? product) {
    if (product == null) return;
    final int index =
        state.products.indexWhere((element) => element.id == product.id);
    if (index < 0) return;
    final List<Product> products = state.products;
    products[index] = product;
    emit(state.copyWith(products: [...products]));
  }

  Future<String?> replenish(
    String companyId,
    String productId,
    double quantity,
  ) async {
    try {
      final int index =
          state.products.indexWhere((element) => element.id == productId);
      if (index < 0) return null;
      final double newQuantity = await service.replenish(
        companyId,
        productId,
        quantity,
      );
      final List<Product> products = state.products;
      products[index] = products[index].copyWith(quantity: newQuantity);
      emit(state.copyWith(products: [...products]));
    } on Exception catch (e) {
      return e.toString();
    } finally {}
    return null;
  }
}
