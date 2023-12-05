import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sales_control/app/cubits/app_cubit.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/src/customer_search_history/domain/customer_search_history.dart';
import 'package:sales_control/ui/pages/sell/cubits/sell_cubit.dart';
import 'package:sales_control/ui/pages/sell/states/sell_state.dart';
import 'package:sales_control/ui/routes/route_name.dart';
import 'package:sales_control/ui/widgets/customer_search_delegate.dart';

class SellCustomerInformation extends StatelessWidget {
  const SellCustomerInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SellCubit, SellState, Customer?>(
      selector: (state) => state.customer,
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              title: Text(
                state == null
                    ? AppLocalizations.of(context)!.search
                    : state.idCard,
              ),
              onTap: () async {
                context.loaderOverlay.show();
                final SellCubit cubit = context.read<SellCubit>();
                final List<CustomerSearchHistory> history =
                    await cubit.customerHistory;
                if (!context.mounted) return;
                context.loaderOverlay.hide();
                showSearch(
                  context: context,
                  delegate: CustomerSearchDelegate(
                    companyId: context.read<AppCubit>().state.companyId,
                    history: history,
                  ),
                ).then((value) {
                  context.read<SellCubit>().addCustomer(value);
                });
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FaIcon(FontAwesomeIcons.magnifyingGlass),
                  const SizedBox(width: 10.0),
                  IconButton(
                    onPressed: () {
                      context
                          .pushNamed<Customer?>(RouteName.addCustomer)
                          .then((value) {
                        context.read<SellCubit>().addCustomer(value);
                      });
                    },
                    icon: const FaIcon(FontAwesomeIcons.userPlus),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: const BorderSide(),
              ),
            ),
            if (state != null) const SizedBox(height: 16.0),
            if (state != null)
              ListTile(
                title: Text(state.fullName),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: const BorderSide(),
                ),
              ),
          ],
        );
      },
    );
  }
}
