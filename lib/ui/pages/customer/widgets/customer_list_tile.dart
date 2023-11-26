import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sales_control/app/app.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/ui/pages/customer/cubits/customer_cubit.dart';
import 'package:sales_control/ui/routes/route_name.dart';

class CustomerListTile extends StatelessWidget {
  const CustomerListTile(this.customer, {super.key});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
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
      trailing: IconButton(
        icon: const FaIcon(
          FontAwesomeIcons.trash,
          color: Colors.redAccent,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.delete),
                content: Text(AppLocalizations.of(context)!.areYouSure),
                actions: [
                  TextButton(
                    onPressed: () async {
                      context.loaderOverlay.show();
                      final CustomerCubit cubit = context.read<CustomerCubit>();
                      final String? error = await cubit.delete(customer);
                      if (!context.mounted) return;
                      context.loaderOverlay.hide();
                      if (error != null) {
                        showErrorSnackbar(context, error);
                      }
                      context.pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.yes,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.no,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
