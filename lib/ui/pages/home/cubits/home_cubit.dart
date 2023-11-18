import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/src/auth/domain/auth.dart';
import 'package:sales_control/ui/pages/home/states/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.authService,
  }) : super(const HomeState());

  final AuthService authService;

  Future<void> load() async {
    String error = '';
    Auth? auth;
    try {
      emit(state.copyWith(loading: true, loadingError: error));
      auth = await authService.current;
    } on Exception {
      error = 'loading-error';
    } finally {
      emit(
        state.copyWith(
          loading: false,
          loadingError: error,
          companyId: auth?.uid,
        ),
      );
    }
  }
}
