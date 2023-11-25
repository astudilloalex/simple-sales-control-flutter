import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sales_control/ui/pages/edit_customer/cubits/edit_customer_cubit.dart';
import 'package:sales_control/ui/pages/edit_customer/widgets/edit_customer_form.dart';

class EditCustomerPage extends StatelessWidget {
  const EditCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.read<EditCustomerCubit>().id == null
              ? AppLocalizations.of(context)!.addCustomer
              : AppLocalizations.of(context)!.editCustomer,
        ),
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: EditCustomerForm(),
          ),
        ],
      ),
    );
  }
}
