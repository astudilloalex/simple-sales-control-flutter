import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/ui/pages/customer/cubits/customer_cubit.dart';
import 'package:sales_control/ui/pages/customer/states/customer_state.dart';
import 'package:sales_control/ui/routes/route_name.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, state) {
        if (state.loading) {
          return const LinearProgressIndicator();
        }
        return ListView.separated(
          controller: context.read<CustomerCubit>().customerListController,
          itemBuilder: (context, index) {
            final Customer customer = state.customers[index];
            return ListTile(
              title: Text('${customer.lastName} ${customer.firstName}'),
              subtitle: Text(customer.idCard),
              onTap: () {
                context.pushNamed<Customer?>(
                  RouteName.editCustomer,
                  pathParameters: {'id': customer.id},
                ).then((value) {
                  context.read<CustomerCubit>().updateCustomer(value);
                });
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 0),
          itemCount: state.customers.length,
        );
      },
    );
  }
}
