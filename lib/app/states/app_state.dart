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

  AppState copyWith({
    ThemeData? darkTheme,
    ThemeData? lightTheme,
    ThemeMode? themeMode,
  }) {
    return AppState(
      darkTheme: darkTheme ?? this.darkTheme,
      lightTheme: lightTheme ?? this.lightTheme,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
