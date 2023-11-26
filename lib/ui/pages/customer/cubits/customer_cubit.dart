import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/customer/application/customer_service.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/ui/pages/customer/states/customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit({
    required this.service,
    required this.companyId,
  }) : super(const CustomerState()) {
    customerListController.addListener(_onScrollCustomerList);
  }

  final CustomerService service;
  final String companyId;

  final ScrollController customerListController = ScrollController();
  final int pageSize = 25;

  bool hasMoreCustomers = true;

  Future<void> load([Customer? lastElement]) async {
    List<Customer> customers = [];
    try {
      emit(state.copyWith(loading: true));
      customers = await service.findAll(companyId, pageSize, lastElement);
      if (customers.isEmpty) hasMoreCustomers = false;
    } on Exception catch (e) {
      emit(state.copyWith(loadingError: e.toString()));
    } finally {
      emit(state.copyWith(loading: false, customers: customers));
    }
  }

  Future<void> _onScrollCustomerList() async {
    if (customerListController.position.pixels ==
            customerListController.position.maxScrollExtent &&
        hasMoreCustomers &&
        !state.loadingPagination) {
      List<Customer> customers = [];
      try {
        emit(state.copyWith(loadingPagination: true));
        customers = await service.findAll(
          companyId,
          pageSize,
          state.customers.last,
        );
        if (customers.isEmpty || customers.length < pageSize) {
          hasMoreCustomers = false;
        }
      } on Exception catch (e) {
        emit(state.copyWith(loadingError: e.toString()));
      } finally {
        emit(
          state.copyWith(
            loading: false,
            loadingPagination: false,
            customers: [...state.customers, ...customers],
          ),
        );
      }
    }
  }

  Future<String?> delete(Customer customer) async {
    try {
      await service.delete(companyId, customer.id);
      final List<Customer> customers = state.customers;
      customers.removeWhere((c) => c.id == customer.id);
      emit(state.copyWith(customers: customers));
    } on Exception catch (e) {
      return e.toString();
    }
    return null;
  }

  void addCustomer(Customer? customer) {
    if (customer == null) return;
    emit(state.copyWith(customers: [...state.customers, customer]));
  }

  void updateCustomer(Customer? customer) {
    if (customer == null) return;
    final int index =
        state.customers.indexWhere((element) => element.id == customer.id);
    if (index < 0) return;
    final List<Customer> customers = state.customers;
    customers[index] = customer;
    customers.sort((a, b) => a.lastName.compareTo(b.lastName));
    emit(state.copyWith(customers: [...customers]));
  }

  @override
  Future<void> close() {
    customerListController.dispose();
    return super.close();
  }
}
