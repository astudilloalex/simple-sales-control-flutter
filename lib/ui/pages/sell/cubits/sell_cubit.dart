import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/src/customer_search_history/application/customer_search_history_service.dart';
import 'package:sales_control/src/customer_search_history/domain/customer_search_history.dart';
import 'package:sales_control/ui/pages/sell/states/sell_state.dart';

class SellCubit extends Cubit<SellState> {
  SellCubit({
    required this.customerSearchHistoryService,
  }) : super(const SellState());

  final CustomerSearchHistoryService customerSearchHistoryService;

  void addCustomer(Customer? customer) {
    if (customer == null) return;
    emit(state.copyWith(customer: customer));
  }

  Future<List<CustomerSearchHistory>> get history async {
    return customerSearchHistoryService.getAll(1, 100);
  }
}
