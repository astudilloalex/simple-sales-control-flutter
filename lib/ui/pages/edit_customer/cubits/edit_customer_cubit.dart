import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/customer/application/customer_service.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/ui/pages/edit_customer/states/edit_customer_state.dart';

class EditCustomerCubit extends Cubit<EditCustomerState> {
  EditCustomerCubit({
    this.id,
    required this.companyId,
    required this.service,
  }) : super(const EditCustomerState());

  final String? id;
  final String companyId;
  final CustomerService service;

  Future<void> load() async {
    if (id == null) return;
    Customer? customer;
    try {
      customer = await service.getById(companyId, id!);
    } finally {
      emit(state.copyWith(customer: customer));
    }
  }

  Future<String?> saveOrUpdate(Customer customer) async {
    Customer? savedCustomer;
    try {
      savedCustomer = id == null
          ? await service.add(customer)
          : await service.update(customer);
    } on Exception catch (e) {
      return e.toString();
    } finally {
      emit(state.copyWith(customer: savedCustomer));
    }
    return null;
  }
}
