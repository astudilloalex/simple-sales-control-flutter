import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/file/application/file_service.dart';
import 'package:sales_control/src/product/application/product_service.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/ui/pages/edit_product/states/edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit({
    required this.service,
    required this.fileService,
    this.id,
  }) : super(const EditProductState());

  final FileService fileService;
  final ProductService service;
  final String? id;

  Product? product;

  Future<String?> loadProduct(String companyId) async {
    Product? product;
    try {
      if (id == null) return null;
      emit(state.copyWith(loading: true));
      product = await service.getById(companyId, id ?? '');
    } catch (e) {
      return e.toString();
    } finally {
      emit(state.copyWith(loading: false, product: product));
    }
    return null;
  }

  Future<String?> addProduct(Product product) async {
    try {
      emit(state.copyWith(product: await service.save(product)));
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<String?> updateProduct(Product product) async {
    try {
      emit(state.copyWith(product: await service.update(product)));
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<String> addImage(File file) {
    return fileService.uploadFile(file);
  }

  Future<void> removeImage(String url) async {
    await fileService.deleteFile(url);
  }
}
