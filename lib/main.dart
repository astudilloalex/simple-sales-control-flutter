import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sales_control/app/cubits/app_cubit.dart';
import 'package:sales_control/app/services/get_it_service.dart';
import 'package:sales_control/app/states/app_state.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/ui/routes/route_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupGetIt();
  // Check crash app error with crashlytics
  FlutterError.onError = (details) =>
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      fatal: true,
    );
    return true;
  };
  // Use hive to save local data.
  final Directory directory = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = directory.path;
  // Run the app.
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(
            authService: getIt<AuthService>(),
          )..load(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) => const Center(
        child: SpinKitPulsingGrid(
          color: Colors.white,
        ),
      ),
      overlayColor: Colors.black.withOpacity(0.7),
      // Use cubit to manage state globally.
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state.loading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          return MaterialApp.router(
            darkTheme: state.darkTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            routerConfig: RoutePage.router,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: state.lightTheme,
            themeMode: state.themeMode,
          );
        },
      ),
    );
  }
}
