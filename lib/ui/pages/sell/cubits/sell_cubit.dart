import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/src/customer_search_history/application/customer_search_history_service.dart';
import 'package:sales_control/src/customer_search_history/domain/customer_search_history.dart';
import 'package:sales_control/src/product_search_history/application/product_search_history_service.dart';
import 'package:sales_control/src/product_search_history/domain/product_search_history.dart';
import 'package:sales_control/ui/pages/sell/states/sell_state.dart';

class SellCubit extends Cubit<SellState> {
  SellCubit({
    required this.customerSearchHistoryService,
    required this.productSearchHistoryService,
  }) : super(const SellState());

  final CustomerSearchHistoryService customerSearchHistoryService;
  final ProductSearchHistoryService productSearchHistoryService;

  void addCustomer(Customer? customer) {
    if (customer == null) return;
    emit(state.copyWith(customer: customer));
  }

  Future<List<CustomerSearchHistory>> get customerHistory async {
    return customerSearchHistoryService.getAll(1, 100);
  }

  Future<List<ProductSearchHistory>> get productHistory async {
    return productSearchHistoryService.getAll(1, 100);
  }
}
