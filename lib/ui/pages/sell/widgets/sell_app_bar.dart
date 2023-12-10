import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SellAppBar extends StatelessWidget {
  const SellAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(AppLocalizations.of(context)!.sell),
    );
  }
}
