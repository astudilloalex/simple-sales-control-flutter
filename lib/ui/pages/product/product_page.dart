import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/ui/pages/product/cubits/product_cubit.dart';
import 'package:sales_control/ui/pages/product/widgets/product_list.dart';
import 'package:sales_control/ui/routes/route_name.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.products),
      ),
      body: const ProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed<Product?>(RouteName.addProduct).then((value) {
            context.read<ProductCubit>().addProduct(value);
          });
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
