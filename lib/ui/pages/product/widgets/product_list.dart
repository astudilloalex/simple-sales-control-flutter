import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/ui/pages/product/cubits/product_cubit.dart';
import 'package:sales_control/ui/pages/product/states/product_state.dart';
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
        return ListView.builder(
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
              subtitle: Text(
                product.description ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              trailing: Text('${product.quantity}'),
            );
          },
        );
      },
    );
  }
}
