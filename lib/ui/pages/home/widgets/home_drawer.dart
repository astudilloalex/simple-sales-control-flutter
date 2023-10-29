import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/src/auth/domain/auth.dart';
import 'package:sales_control/ui/pages/home/cubits/home_drawer_cubit.dart';
import 'package:sales_control/ui/pages/home/states/home_drawer_state.dart';
import 'package:sales_control/ui/routes/route_name.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: BlocSelector<HomeDrawerCubit, HomeDrawerState, Auth>(
              selector: (state) => state.currentUser,
              builder: (context, state) {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        state.photoURL ??
                            'https://i.postimg.cc/3wttDx6S/user-circular-avatar.png',
                      ),
                      radius: 35.0,
                    ),
                    const SizedBox(height: 5.0),
                    Text(state.displayName ?? ''),
                    const SizedBox(height: 5.0),
                    Text(
                      state.email ?? '',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.gear),
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () {
              if (Scaffold.of(context).isDrawerOpen) {
                context.pop();
              }
              context.pushNamed(RouteName.setting);
            },
          ),
        ],
      ),
    );
  }
}
