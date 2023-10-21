import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/ui/pages/sign_in/states/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());
}
