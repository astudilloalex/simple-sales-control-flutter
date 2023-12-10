import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/src/customer_search_history/application/customer_search_history_service.dart';
import 'package:sales_control/src/customer_search_history/domain/customer_search_history.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/src/product_search_history/application/product_search_history_service.dart';
import 'package:sales_control/src/product_search_history/domain/product_search_history.dart';
import 'package:sales_control/src/sale/domain/sale.dart';
import 'package:sales_control/src/sale_detail/domain/sale_detail.dart';
import 'package:sales_control/ui/pages/sell/states/sell_state.dart';

class SellCubit extends Cubit<SellState> {
  SellCubit({
    required this.customerSearchHistoryService,
    required this.productSearchHistoryService,
  }) : super(SellState(sale: Sale(dateTime: DateTime.now())));

  final CustomerSearchHistoryService customerSearchHistoryService;
  final ProductSearchHistoryService productSearchHistoryService;

  void addCustomer(Customer? customer) {
    if (customer == null) return;
    emit(state.copyWith(customer: customer));
  }

  void addProduct(Product? product) {
    if (product == null || product.quantity <= 0.0) return;
    final int index = state.sale.saleDetails.indexWhere(
      (sd) => sd.product.id == product.id,
    );
    if (index < 0) {
      final Decimal total =
          Decimal.parse(product.price.toString()) * Decimal.parse('1.0');
      final SaleDetail detail = SaleDetail(
        product: product,
        quantity: 1.0,
        unitCost: product.price,
        total: total.toDouble(),
      );
      emit(
        state.copyWith(
          sale: state.sale.copyWith(
            saleDetails: [...state.sale.saleDetails, detail],
            total:
                (Decimal.parse(state.sale.total.toString()) + total).toDouble(),
          ),
        ),
      );
    }
  }

  void removeSaleDetail(String productId) {
    final int index = state.sale.saleDetails.indexWhere(
      (sd) => sd.product.id == productId,
    );
    if (index < 0) return;
    final SaleDetail detail = state.sale.saleDetails[index];
    final Decimal total = Decimal.parse(state.sale.total.toString()) -
        Decimal.parse(detail.total.toString());
    final List<SaleDetail> saleDetails = [...state.sale.saleDetails];
    saleDetails.removeAt(index);
    emit(
      state.copyWith(
        sale: state.sale.copyWith(
          saleDetails: [...saleDetails],
          total: total.toDouble(),
        ),
      ),
    );
  }

  double changeQuantity(String productId, double quantity, [bool sum = false]) {
    final int index = state.sale.saleDetails.indexWhere(
      (sd) => sd.product.id == productId,
    );
    if (index < 0) return 1.0;
    SaleDetail detail = state.sale.saleDetails[index];
    final double newQuantity = sum
        ? (Decimal.parse(quantity.toString()) +
                Decimal.parse(detail.quantity.toString()))
            .toDouble()
        : quantity;
    if (newQuantity <= 0) return detail.quantity;
    Decimal total = Decimal.parse(state.sale.total.toString()) -
        Decimal.parse(detail.total.toString());
    final Decimal totalDetail = Decimal.parse(detail.unitCost.toString()) *
        Decimal.parse(newQuantity.toString());
    detail = detail.copyWith(
      quantity: newQuantity,
      total: totalDetail.toDouble(),
    );
    total += totalDetail;
    final List<SaleDetail> saleDetails = [...state.sale.saleDetails];
    saleDetails[index] = detail;
    emit(
      state.copyWith(
        sale: state.sale
            .copyWith(saleDetails: saleDetails, total: total.toDouble()),
      ),
    );
    return newQuantity;
  }

  Future<String?> sell(String companyId) async {}

  Future<List<CustomerSearchHistory>> get customerHistory async {
    return customerSearchHistoryService.getAll(1, 100);
  }

  Future<List<ProductSearchHistory>> get productHistory async {
    return productSearchHistoryService.getAll(1, 100);
  }
}
