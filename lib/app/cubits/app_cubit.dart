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
}
