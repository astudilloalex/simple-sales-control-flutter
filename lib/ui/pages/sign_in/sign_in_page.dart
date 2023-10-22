import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sales_control/app/app.dart';
import 'package:sales_control/app/app_asset.dart';
import 'package:sales_control/ui/pages/sign_in/cubits/sign_in_cubit.dart';
import 'package:sales_control/ui/routes/route_name.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 16.0),
              Center(
                child: Image.asset(
                  AppAsset.phoneDollarIcon,
                  color: Colors.black,
                  colorBlendMode: BlendMode.modulate,
                  width: 200.0,
                ),
              ),
              const SizedBox(height: 16.0),
              const SpinKitRipple(
                color: Colors.black,
                duration: Duration(seconds: 3),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    context.loaderOverlay.show();
                    final String? error =
                        await context.read<SignInCubit>().signInWithGoogle();
                    if (!context.mounted) return;
                    context.loaderOverlay.hide();
                    if (error != null) {
                      showErrorSnackbar(context, error);
                      return;
                    }
                    context.goNamed(RouteName.home);
                  },
                  icon: const Icon(FontAwesomeIcons.google),
                  label: Text(AppLocalizations.of(context)!.signInWithGoogle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
