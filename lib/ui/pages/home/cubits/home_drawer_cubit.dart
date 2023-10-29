import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/ui/pages/home/states/home_drawer_state.dart';

class HomeDrawerCubit extends Cubit<HomeDrawerState> {
  HomeDrawerCubit({
    required this.authService,
  }) : super(const HomeDrawerState());

  final AuthService authService;

  Future<void> load() async {
    try {
      emit(
        state.copyWith(loading: true, currentUser: await authService.current),
      );
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
