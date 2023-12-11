import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sales_control/app/cubits/app_cubit.dart';
import 'package:sales_control/app/services/get_it_service.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/ui/pages/home/cubits/home_cubit.dart';
import 'package:sales_control/ui/pages/home/cubits/home_drawer_cubit.dart';
import 'package:sales_control/ui/pages/home/states/home_state.dart';
import 'package:sales_control/ui/pages/home/widgets/home_drawer.dart';
import 'package:sales_control/ui/pages/home/widgets/sale_line_chart.dart';
import 'package:sales_control/ui/routes/route_name.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.salesControl),
        centerTitle: true,
      ),
      drawer: BlocProvider(
        create: (context) => HomeDrawerCubit(
          authService: getIt<AuthService>(),
        )..load(),
        child: const HomeDrawer(),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          // Show loading overlay.
          if (state.loading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
            context.read<AppCubit>().updateCurrentCompany(state.companyId);
          }
          return const SaleLineChart();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(RouteName.sell);
        },
        label: Text(AppLocalizations.of(context)!.sell),
        icon: const FaIcon(FontAwesomeIcons.handPointer),
      ),
    );
  }
}
