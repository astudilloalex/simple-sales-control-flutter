import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/ui/pages/sign_in/states/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.authService,
  }) : super(const SignInState());

  final AuthService authService;

  Future<String?> signInWithGoogle() async {
    try {
      await authService.signInWithGoogle();
    } on Exception catch (e) {
      return e.toString();
    }
    return null;
  }
}
