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
                    SizedBox(
                      height: 80.0,
                      child: Center(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  state.photoURL ??
                                      'https://i.postimg.cc/3wttDx6S/user-circular-avatar.png',
                                ),
                                radius: 35.0,
                              ),
                            ),
                            /* Positioned(
                              right: 0.0,
                              top: 15.0,
                              child: IconButton(
                                onPressed: state.uid.isEmpty
                                    ? null
                                    : () {
                                        if (Scaffold.of(context).isDrawerOpen) {
                                          context.pop();
                                        }
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return QRModalBottomSheet(
                                              data: state.uid,
                                            );
                                          },
                                        );
                                      },
                                icon: const Icon(FontAwesomeIcons.shareNodes),
                              ),
                            ), */
                          ],
                        ),
                      ),
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
            leading: const Icon(FontAwesomeIcons.person),
            title: Text(AppLocalizations.of(context)!.customers),
            onTap: () {
              if (Scaffold.of(context).isDrawerOpen) {
                context.pop();
              }
              context.pushNamed(RouteName.customer);
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.productHunt),
            title: Text(AppLocalizations.of(context)!.products),
            onTap: () {
              if (Scaffold.of(context).isDrawerOpen) {
                context.pop();
              }
              context.pushNamed(RouteName.product);
            },
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
