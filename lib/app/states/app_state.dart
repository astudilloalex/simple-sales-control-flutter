import 'package:flutter/material.dart';

class AppState {
  const AppState({
    required this.darkTheme,
    required this.lightTheme,
    this.themeMode = ThemeMode.system,
    this.companyId = '',
    this.loading = false,
    this.loadingError = '',
  });

  final ThemeData darkTheme;
  final ThemeData lightTheme;
  final ThemeMode themeMode;
  final String companyId;
  final bool loading;
  final String loadingError;

  AppState copyWith({
    ThemeData? darkTheme,
    ThemeData? lightTheme,
    ThemeMode? themeMode,
    String? companyId,
    bool? loading,
    String? loadingError,
  }) {
    return AppState(
      darkTheme: darkTheme ?? this.darkTheme,
      lightTheme: lightTheme ?? this.lightTheme,
      themeMode: themeMode ?? this.themeMode,
      companyId: companyId ?? this.companyId,
      loading: loading ?? this.loading,
      loadingError: loadingError ?? this.loadingError,
    );
  }
}
