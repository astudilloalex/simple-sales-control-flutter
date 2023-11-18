import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRModalBottomSheet extends StatelessWidget {
  const QRModalBottomSheet({super.key, this.data = ''});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(FontAwesomeIcons.xmark),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Center(
                child: QrImageView(
                  data: data,
                  size: MediaQuery.of(context).size.width * 0.75,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(data),
                  IconButton(
                    onPressed: () async {
                      context.loaderOverlay.show();
                      await Clipboard.setData(ClipboardData(text: data));
                      if (!context.mounted) return;
                      context.loaderOverlay.hide();
                      context.pop();
                    },
                    icon: const Icon(FontAwesomeIcons.copy),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
