import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/ui/pages/onboarding/cubits/onboarding_cubit.dart';
import 'package:sales_control/ui/pages/onboarding/onboarding_page.dart';
import 'package:sales_control/ui/pages/sign_in/cubits/sign_in_cubit.dart';
import 'package:sales_control/ui/pages/sign_in/sign_in_page.dart';
import 'package:sales_control/ui/pages/splash/cubits/splash_cubit.dart';
import 'package:sales_control/ui/pages/splash/splash_page.dart';
import 'package:sales_control/ui/routes/route_name.dart';

/// Pages availables.
class RoutePage {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  const RoutePage._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.onboarding,
        name: RouteName.onboarding,
        builder: (context, state) => BlocProvider(
          create: (context) => OnboardingCubit(),
          child: const OnboardingPage(),
        ),
      ),
      GoRoute(
        path: RouteName.signIn,
        name: RouteName.signIn,
        builder: (context, state) => BlocProvider(
          create: (context) => SignInCubit(),
          child: const SignInPage(),
        ),
      ),
      GoRoute(
        path: RouteName.splash,
        name: RouteName.splash,
        builder: (context, state) => BlocProvider(
          create: (context) => SplashCubit(),
          child: const SplashPage(),
        ),
      ),
    ],
  );
}
