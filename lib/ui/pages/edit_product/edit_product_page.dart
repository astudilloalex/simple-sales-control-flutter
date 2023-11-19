import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sales_control/ui/pages/edit_product/cubits/edit_product_cubit.dart';
import 'package:sales_control/ui/pages/edit_product/widgets/edit_product_form.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.read<EditProductCubit>().id == null
              ? AppLocalizations.of(context)!.addProduct
              : AppLocalizations.of(context)!.editProduct,
        ),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: EditProductForm(),
          ),
        ],
      ),
    );
  }
}
