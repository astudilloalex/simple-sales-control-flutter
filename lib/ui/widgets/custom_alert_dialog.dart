import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAlerDialog extends StatelessWidget {
  const CustomAlerDialog({
    super.key,
    this.title = '',
    this.content,
    this.onYesAction,
    this.onNoAction,
  });

  final String title;
  final Widget? content;
  final VoidCallback? onYesAction;
  final VoidCallback? onNoAction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: onYesAction,
          child: Text(
            AppLocalizations.of(context)!.yes,
            style: const TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ),
        TextButton(
          onPressed: onNoAction,
          child: Text(AppLocalizations.of(context)!.no),
        ),
      ],
    );
  }
}
