import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/src/sale_detail/domain/sale_detail.dart';
import 'package:sales_control/ui/pages/sell/cubits/sell_cubit.dart';
import 'package:sales_control/ui/widgets/custom_alert_dialog.dart';

class SellProductDetail extends StatelessWidget {
  const SellProductDetail({super.key, required this.saleDetail});

  final SaleDetail saleDetail;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  saleDetail.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return CustomAlerDialog(
                          title: AppLocalizations.of(context)!.delete,
                          content:
                              Text(AppLocalizations.of(context)!.areYouSure),
                          onNoAction: () => context.pop(),
                          onYesAction: () {
                            context
                                .read<SellCubit>()
                                .removeSaleDetail(saleDetail.product.id);
                            context.pop();
                          },
                        );
                      },
                    );
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.trash,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            _QuantityInput(saleDetail),
          ],
        ),
      ),
    );
  }
}

class _QuantityInput extends StatefulWidget {
  const _QuantityInput(this.saleDetail);

  final SaleDetail saleDetail;

  @override
  State<_QuantityInput> createState() => _QuantityInputState();
}

class _QuantityInputState extends State<_QuantityInput> {
  final TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityController.text = widget.saleDetail.quantity.toStringAsFixed(2);
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            final double newQuantity = context.read<SellCubit>().changeQuantity(
                  widget.saleDetail.product.id,
                  -1.0,
                  true,
                );
            quantityController.text = newQuantity.toStringAsFixed(2);
          },
          icon: const FaIcon(FontAwesomeIcons.minus),
        ),
        SizedBox(
          width: 75.0,
          child: Theme(
            data: Theme.of(context).copyWith(
              visualDensity: const VisualDensity(vertical: -4.0),
            ),
            child: TextFormField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final double? quantity =
                    double.tryParse(quantityController.text);
                final double newQuantity =
                    context.read<SellCubit>().changeQuantity(
                          widget.saleDetail.product.id,
                          quantity ?? widget.saleDetail.quantity,
                        );
                if (quantity == null && quantityController.text.isNotEmpty) {
                  quantityController.text = newQuantity.toStringAsFixed(2);
                }
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            final double newQuantity = context.read<SellCubit>().changeQuantity(
                  widget.saleDetail.product.id,
                  1.0,
                  true,
                );
            quantityController.text = newQuantity.toStringAsFixed(2);
          },
          icon: const FaIcon(FontAwesomeIcons.plus),
        ),
      ],
    );
  }
}
