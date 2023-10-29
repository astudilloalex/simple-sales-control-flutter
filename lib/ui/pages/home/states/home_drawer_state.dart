import 'package:sales_control/src/auth/domain/auth.dart';

class HomeDrawerState {
  const HomeDrawerState({
    this.currentUser = const Auth(uid: ''),
    this.loading = false,
  });

  final Auth currentUser;
  final bool loading;

  HomeDrawerState copyWith({
    Auth? currentUser,
    bool? loading,
  }) {
    return HomeDrawerState(
      currentUser: currentUser ?? this.currentUser,
      loading: loading ?? this.loading,
    );
  }
}
