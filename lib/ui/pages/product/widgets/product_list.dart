import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sales_control/app/app.dart';
import 'package:sales_control/app/cubits/app_cubit.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/ui/pages/product/cubits/product_cubit.dart';
import 'package:sales_control/ui/pages/product/states/product_state.dart';
import 'package:sales_control/ui/pages/product/widgets/replenish_product_bottom_sheet.dart';
import 'package:sales_control/ui/routes/route_name.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.loading) {
          return const LinearProgressIndicator();
        }
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(height: 0.0),
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            final Product product = state.products[index];
            return ListTile(
              leading: product.photoUrls.isEmpty
                  ? const SizedBox(width: 50.0)
                  : Image.network(
                      product.photoUrls[0],
                      fit: BoxFit.cover,
                      width: 50.0,
                    ),
              title: Text(product.name),
              onTap: () {
                context.pushNamed<Product?>(
                  RouteName.editProduct,
                  pathParameters: {'id': product.id},
                ).then((value) {
                  context.read<ProductCubit>().updateProduct(value);
                });
              },
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.description ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '\$ ${product.price.toStringAsFixed(2)} - ${product.quantity.toStringAsFixed(2)}',
                  ),
                ],
              ),
              trailing: PopupMenuButton(
                onSelected: (value) async {
                  if (value == 1) {
                    final double? quantity =
                        await showModalBottomSheet<double?>(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: const ReplenishProductBottomSheet(),
                        );
                      },
                    );
                    if (quantity == null) return;
                    if (!context.mounted) return;
                    final ProductCubit cubit = context.read<ProductCubit>();
                    context.loaderOverlay.show();
                    final String? error = await cubit.replenish(
                      context.read<AppCubit>().state.companyId,
                      product.id,
                      quantity,
                    );
                    if (!context.mounted) return;
                    context.loaderOverlay.hide();
                    if (error != null) showErrorSnackbar(context, error);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text(AppLocalizations.of(context)!.replenish),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
