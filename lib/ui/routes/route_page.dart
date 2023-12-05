import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/app/cubits/app_cubit.dart';
import 'package:sales_control/app/services/get_it_service.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/src/company/application/company_service.dart';
import 'package:sales_control/src/customer/application/customer_service.dart';
import 'package:sales_control/src/customer_search_history/application/customer_search_history_service.dart';
import 'package:sales_control/src/file/application/file_service.dart';
import 'package:sales_control/src/product/application/product_service.dart';
import 'package:sales_control/src/product_search_history/application/product_search_history_service.dart';
import 'package:sales_control/ui/pages/customer/cubits/customer_cubit.dart';
import 'package:sales_control/ui/pages/customer/customer_page.dart';
import 'package:sales_control/ui/pages/edit_company/cubits/edit_company_cubit.dart';
import 'package:sales_control/ui/pages/edit_company/edit_company_page.dart';
import 'package:sales_control/ui/pages/edit_customer/cubits/edit_customer_cubit.dart';
import 'package:sales_control/ui/pages/edit_customer/edit_customer_page.dart';
import 'package:sales_control/ui/pages/edit_product/cubits/edit_product_cubit.dart';
import 'package:sales_control/ui/pages/edit_product/edit_product_page.dart';
import 'package:sales_control/ui/pages/home/cubits/home_cubit.dart';
import 'package:sales_control/ui/pages/home/home_page.dart';
import 'package:sales_control/ui/pages/onboarding/cubits/onboarding_cubit.dart';
import 'package:sales_control/ui/pages/onboarding/onboarding_page.dart';
import 'package:sales_control/ui/pages/product/cubits/product_cubit.dart';
import 'package:sales_control/ui/pages/product/product_page.dart';
import 'package:sales_control/ui/pages/sell/cubits/sell_cubit.dart';
import 'package:sales_control/ui/pages/sell/sell_page.dart';
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
        path: RouteName.addCustomer,
        name: RouteName.addCustomer,
        builder: (context, state) => BlocProvider(
          create: (context) => EditCustomerCubit(
            companyId: context.read<AppCubit>().state.companyId,
            service: getIt<CustomerService>(),
          ),
          child: const EditCustomerPage(),
        ),
      ),
      GoRoute(
        path: RouteName.addProduct,
        name: RouteName.addProduct,
        builder: (context, state) => BlocProvider(
          create: (context) => EditProductCubit(
            fileService: getIt<FileService>(),
            service: getIt<ProductService>(),
          ),
          child: const EditProductPage(),
        ),
      ),
      GoRoute(
        path: RouteName.customer,
        name: RouteName.customer,
        builder: (context, state) => BlocProvider(
          create: (context) => CustomerCubit(
            service: getIt<CustomerService>(),
            companyId: context.read<AppCubit>().state.companyId,
          )..load(),
          child: const CustomerPage(),
        ),
      ),
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
        path: RouteName.editCustomer,
        name: RouteName.editCustomer,
        builder: (context, state) => BlocProvider(
          create: (context) => EditCustomerCubit(
            id: state.pathParameters['id'] ?? '',
            service: getIt<CustomerService>(),
            companyId: context.read<AppCubit>().state.companyId,
          ),
          child: const EditCustomerPage(),
        ),
      ),
      GoRoute(
        path: RouteName.editProduct,
        name: RouteName.editProduct,
        builder: (context, state) => BlocProvider(
          create: (context) => EditProductCubit(
            fileService: getIt<FileService>(),
            id: state.pathParameters['id'] ?? '',
            service: getIt<ProductService>(),
          ),
          child: const EditProductPage(),
        ),
      ),
      GoRoute(
        path: RouteName.home,
        name: RouteName.home,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeCubit(
            authService: getIt<AuthService>(),
          )..load(),
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
        path: RouteName.product,
        name: RouteName.product,
        builder: (context, state) => BlocProvider(
          create: (context) => ProductCubit(
            service: getIt<ProductService>(),
            companyId: context.read<AppCubit>().state.companyId,
          )..load(),
          child: const ProductPage(),
        ),
      ),
      GoRoute(
        path: RouteName.sell,
        name: RouteName.sell,
        builder: (context, state) => BlocProvider(
          create: (context) => SellCubit(
            customerSearchHistoryService: getIt<CustomerSearchHistoryService>(),
            productSearchHistoryService: getIt<ProductSearchHistoryService>(),
          ),
          child: const SellPage(),
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
