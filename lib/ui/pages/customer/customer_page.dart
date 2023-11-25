import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/ui/pages/customer/cubits/customer_cubit.dart';
import 'package:sales_control/ui/pages/customer/widgets/customer_list.dart';
import 'package:sales_control/ui/routes/route_name.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.customers),
      ),
      body: const CustomerList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed<Customer?>(RouteName.addCustomer).then((value) {
            context.read<CustomerCubit>().addCustomer(value);
          });
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
