import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/src/auth/domain/auth.dart';
import 'package:sales_control/ui/pages/splash/states/splash_state.dart';
import 'package:sales_control/ui/routes/route_name.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.authService,
  }) : super(const SplashState());

  final AuthService authService;

  Future<String> get routeName async {
    try {
      final Auth? auth = await authService.current;
      if (auth == null) return RouteName.signIn;
      return RouteName.onboarding;
    } on Exception {
      return RouteName.signIn;
    }
  }
}
