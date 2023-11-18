import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/product/application/product_service.dart';
import 'package:sales_control/ui/pages/product/states/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.service,
  }) : super(const ProductState());

  final ProductService service;
}
