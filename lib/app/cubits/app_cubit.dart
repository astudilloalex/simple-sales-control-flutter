import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/app/states/app_state.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required this.authService,
  }) : super(
          AppState(
            darkTheme: ThemeData.dark(),
            lightTheme: ThemeData.light(),
          ),
        );

  final AuthService authService;

  Future<void> load() async {
    emit(
      state.copyWith(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }

  void updateCurrentCompany(String companyId) {
    emit(state.copyWith(companyId: companyId));
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
    );
  }

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        errorBorder: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
        disabledBorder: OutlineInputBorder(),
        focusedErrorBorder: OutlineInputBorder(),
      ),
      visualDensity: VisualDensity.compact,
    );
  }
}
