import 'package:flutter/material.dart';
import 'package:sales_control/src/auth/domain/auth.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.user,
  });

  final Auth user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: user.photoURL == null
          ? null
          : CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
            ),
      title: Text(user.displayName ?? '...'),
      subtitle: Text(user.email ?? '...'),
    );
  }
}
