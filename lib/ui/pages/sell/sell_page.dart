import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sales_control/app/app.dart';
import 'package:sales_control/app/cubits/app_cubit.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/src/product_search_history/domain/product_search_history.dart';
import 'package:sales_control/ui/pages/sell/cubits/sell_cubit.dart';
import 'package:sales_control/ui/pages/sell/widgets/sell_app_bar.dart';
import 'package:sales_control/ui/pages/sell/widgets/sell_customer_information.dart';
import 'package:sales_control/ui/pages/sell/widgets/sell_detail_list.dart';
import 'package:sales_control/ui/widgets/product_search_delegate.dart';

class SellPage extends StatelessWidget {
  const SellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SellAppBar(),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  AppLocalizations.of(context)!.customer,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SellCustomerInformation(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  AppLocalizations.of(context)!.details,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ]),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 8.0,
              bottom: 8.0,
            ),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () async {
                      final SellCubit cubit = context.read<SellCubit>();
                      context.loaderOverlay.show();
                      final List<ProductSearchHistory> history =
                          await cubit.productHistory;
                      if (!context.mounted) return;
                      context.loaderOverlay.hide();
                      showSearch<Product?>(
                        context: context,
                        delegate: ProductSearchDelegate(
                          companyId: context.read<AppCubit>().state.companyId,
                          history: history,
                        ),
                      ).then((value) {
                        cubit.addProduct(value);
                      });
                    },
                    icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.plus),
                  ),
                ],
              ),
            ),
          ),
          const SellDetailList(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(AppLocalizations.of(context)!.sell),
                      content: Text(
                        '${AppLocalizations.of(context)!.proceedWithSale}: \$ ${context.read<SellCubit>().state.sale.total}',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                            _finalizeSale(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.yes,
                            style: const TextStyle(
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(AppLocalizations.of(context)!.no),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const FaIcon(FontAwesomeIcons.tableList),
              label: Text(AppLocalizations.of(context)!.finish),
            ),
            Text(
              '${AppLocalizations.of(context)!.total}\n${context.select((SellCubit value) => value.state.sale.total)}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _finalizeSale(BuildContext context) async {
    final SellCubit cubit = context.read<SellCubit>();
    if (cubit.state.customer == null) {
      showErrorSnackbar(
        context,
        AppLocalizations.of(context)!.enterCustomerInformation,
      );
      return;
    }
    if (cubit.state.sale.saleDetails.isEmpty) {
      showErrorSnackbar(
        context,
        AppLocalizations.of(context)!.addLeastOneProduct,
      );
      return;
    }
  }
}
