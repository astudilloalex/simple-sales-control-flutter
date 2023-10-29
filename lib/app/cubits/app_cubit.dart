import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/app/states/app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          AppState(
            darkTheme: ThemeData.dark(),
            lightTheme: ThemeData.light(),
          ),
        );

  Future<void> load() async {
    emit(
      state.copyWith(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
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
