import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ReplenishProductBottomSheet extends StatefulWidget {
  const ReplenishProductBottomSheet({super.key});

  @override
  State<ReplenishProductBottomSheet> createState() =>
      _ReplenishProductBottomSheetState();
}

class _ReplenishProductBottomSheetState
    extends State<ReplenishProductBottomSheet> {
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ),
          TextFormField(
            controller: quantityController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.quantity,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8.0),
          ElevatedButton.icon(
            onPressed: () {
              final double? quantity = double.tryParse(quantityController.text);
              context.pop(quantity == null || quantity <= 0 ? null : quantity);
            },
            icon: const FaIcon(FontAwesomeIcons.rotateRight),
            label: Text(AppLocalizations.of(context)!.update),
          ),
        ],
      ),
    );
  }
}
