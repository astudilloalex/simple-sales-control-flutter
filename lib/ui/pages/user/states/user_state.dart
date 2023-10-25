import 'package:sales_control/src/auth/domain/auth.dart';

class UserState {
  const UserState({
    this.loading = false,
    this.users = const [],
  });

  final bool loading;
  final List<Auth> users;

  UserState copyWith({
    bool? loading,
    List<Auth>? users,
  }) {
    return UserState(
      loading: loading ?? this.loading,
      users: users ?? this.users,
    );
  }
}
