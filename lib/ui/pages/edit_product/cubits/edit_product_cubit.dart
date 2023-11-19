import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/product/application/product_service.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/ui/pages/edit_product/states/edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit({
    required this.service,
    this.id,
  }) : super(const EditProductState());

  final ProductService service;
  final String? id;

  Future<String?> addProduct(Product product) async {
    return null;
  }
}
