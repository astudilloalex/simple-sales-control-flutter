import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/src/auth/domain/auth.dart';
import 'package:sales_control/ui/pages/setting/states/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit({
    required this.authService,
  }) : super(const SettingState());

  final AuthService authService;

  Future<Auth?> get current => authService.current;
}
