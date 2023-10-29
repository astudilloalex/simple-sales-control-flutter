import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/app/services/get_it_service.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/src/company/application/company_service.dart';
import 'package:sales_control/ui/pages/edit_company/cubits/edit_company_cubit.dart';
import 'package:sales_control/ui/pages/edit_company/edit_company_page.dart';
import 'package:sales_control/ui/pages/edit_user/cubits/edit_user_cubit.dart';
import 'package:sales_control/ui/pages/edit_user/edit_user_page.dart';
import 'package:sales_control/ui/pages/home/cubits/home_cubit.dart';
import 'package:sales_control/ui/pages/home/home_page.dart';
import 'package:sales_control/ui/pages/onboarding/cubits/onboarding_cubit.dart';
import 'package:sales_control/ui/pages/onboarding/onboarding_page.dart';
import 'package:sales_control/ui/pages/setting/cubits/setting_cubit.dart';
import 'package:sales_control/ui/pages/setting/setting_page.dart';
import 'package:sales_control/ui/pages/sign_in/cubits/sign_in_cubit.dart';
import 'package:sales_control/ui/pages/sign_in/sign_in_page.dart';
import 'package:sales_control/ui/pages/splash/cubits/splash_cubit.dart';
import 'package:sales_control/ui/pages/splash/splash_page.dart';
import 'package:sales_control/ui/pages/user/cubits/user_cubit.dart';
import 'package:sales_control/ui/pages/user/user_page.dart';
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
        path: RouteName.editCompany,
        name: RouteName.editCompany,
        builder: (context, state) => BlocProvider(
          create: (context) => EditCompanyCubit(
            id: state.pathParameters['id'] ?? '',
            companyService: getIt<CompanyService>(),
          ),
          child: const EditCompanyPage(),
        ),
      ),
      GoRoute(
        path: RouteName.editUser,
        name: RouteName.editUser,
        builder: (context, state) => BlocProvider(
          create: (context) => EditUserCubit(
            companyService: getIt<CompanyService>(),
          ),
          child: const EditUserPage(),
        ),
      ),
      GoRoute(
        path: RouteName.home,
        name: RouteName.home,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeCubit(),
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: RouteName.onboarding,
        name: RouteName.onboarding,
        builder: (context, state) => BlocProvider(
          create: (context) => OnboardingCubit(),
          child: const OnboardingPage(),
        ),
      ),
      GoRoute(
        path: RouteName.setting,
        name: RouteName.setting,
        builder: (context, state) => BlocProvider(
          create: (context) => SettingCubit(
            authService: getIt<AuthService>(),
          ),
          child: const SettingPage(),
        ),
      ),
      GoRoute(
        path: RouteName.signIn,
        name: RouteName.signIn,
        builder: (context, state) => BlocProvider(
          create: (context) => SignInCubit(
            authService: getIt<AuthService>(),
            companyService: getIt<CompanyService>(),
          ),
          child: const SignInPage(),
        ),
      ),
      GoRoute(
        path: RouteName.splash,
        name: RouteName.splash,
        builder: (context, state) => BlocProvider(
          create: (context) => SplashCubit(
            authService: getIt<AuthService>(),
          ),
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        path: RouteName.user,
        name: RouteName.user,
        builder: (context, state) => BlocProvider(
          create: (context) => UserCubit(
            companyService: getIt<CompanyService>(),
          )..load(),
          child: const UserPage(),
        ),
      ),
    ],
  );
}
