import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/ui/pages/product/cubits/product_cubit.dart';
import 'package:sales_control/ui/pages/product/states/product_state.dart';
import 'package:sales_control/ui/pages/product/widgets/product_list_tile.dart';

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
          controller: context.read<ProductCubit>().productListController,
          itemBuilder: (context, index) {
            final Product product = state.products[index];
            if (state.loadingPagination && index == state.products.length - 1) {
              return Column(
                children: [
                  ProductListTile(product),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ],
              );
            }
            return ProductListTile(product);
          },
        );
      },
    );
  }
}
