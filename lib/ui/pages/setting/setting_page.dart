import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/ui/routes/route_name.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 200.0,
        children: [
          InkWell(
            onTap: () => context.pushNamed(RouteName.editCompany),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(FontAwesomeIcons.building),
                  Text(AppLocalizations.of(context)!.myCompany),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => context.pushNamed(RouteName.user),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(FontAwesomeIcons.user),
                  Text(AppLocalizations.of(context)!.users),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
