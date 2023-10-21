import 'package:flutter/material.dart';

class AppState {
  const AppState({
    required this.darkTheme,
    required this.lightTheme,
    this.themeMode = ThemeMode.system,
  });

  final ThemeData darkTheme;
  final ThemeData lightTheme;
  final ThemeMode themeMode;
}
