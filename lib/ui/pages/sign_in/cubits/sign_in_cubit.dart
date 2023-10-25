import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/src/auth/domain/auth.dart';
import 'package:sales_control/src/company/application/company_service.dart';
import 'package:sales_control/src/company/domain/company.dart';
import 'package:sales_control/ui/pages/sign_in/states/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.authService,
    required this.companyService,
  }) : super(const SignInState());

  final AuthService authService;
  final CompanyService companyService;

  Future<String?> signInWithGoogle() async {
    try {
      final Auth auth = await authService.signInWithGoogle();
      if (await companyService.getMyCompany() == null) {
        await companyService.save(
          Company(id: auth.uid, name: 'My Company', owner: auth),
        );
      }
    } on Exception catch (e) {
      return e.toString();
    }
    return null;
  }
}
