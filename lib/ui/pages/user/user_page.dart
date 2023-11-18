import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sales_control/ui/pages/user/cubits/user_cubit.dart';
import 'package:sales_control/ui/pages/user/states/user_state.dart';
import 'package:sales_control/ui/pages/user/widgets/user_tile.dart';
import 'package:sales_control/ui/widgets/qr_scan_modal_bottom_sheet.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.users),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state.loading) {
            return const LinearProgressIndicator();
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              return UserTile(user: state.users[index]);
            },
            separatorBuilder: (context, index) => const SizedBox.shrink(),
            itemCount: state.users.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<String?>(
            context: context,
            isScrollControlled: true,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: const QRScanModalBottomSheet(),
            ),
          ).then((value) {
            context.read<UserCubit>().addUser(value ?? '');
          });
        },
        child: const Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
