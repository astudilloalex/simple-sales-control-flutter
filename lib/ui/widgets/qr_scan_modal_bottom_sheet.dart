import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/ui/widgets/qr_scan.dart';

class QRScanModalBottomSheet extends StatefulWidget {
  const QRScanModalBottomSheet({super.key});

  @override
  State<QRScanModalBottomSheet> createState() => _QRScanModalBottomSheetState();
}

class _QRScanModalBottomSheetState extends State<QRScanModalBottomSheet> {
  final TextEditingController uidController = TextEditingController();

  @override
  void dispose() {
    uidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(FontAwesomeIcons.xmark),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextFormField(
            controller: uidController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push<String?>(
                    MaterialPageRoute(
                      builder: (context) => const QRScan(),
                    ),
                  )
                      .then((value) {
                    uidController.text = value ?? '';
                  });
                },
                icon: const Icon(FontAwesomeIcons.qrcode),
              ),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            context.pop(uidController.text.trim());
          },
          icon: const Icon(FontAwesomeIcons.plus),
          label: Text(AppLocalizations.of(context)!.add),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
