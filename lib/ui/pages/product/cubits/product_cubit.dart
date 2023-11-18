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
}
