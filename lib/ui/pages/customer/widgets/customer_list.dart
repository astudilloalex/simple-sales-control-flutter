import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/ui/pages/customer/cubits/customer_cubit.dart';
import 'package:sales_control/ui/pages/customer/states/customer_state.dart';
import 'package:sales_control/ui/pages/customer/widgets/customer_list_tile.dart';

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
            if (state.loadingPagination &&
                index == state.customers.length - 1) {
              return Column(
                children: [
                  CustomerListTile(customer),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ],
              );
            }
            return CustomerListTile(customer);
          },
          separatorBuilder: (context, index) => const Divider(height: 0),
          itemCount: state.customers.length,
        );
      },
    );
  }
}
