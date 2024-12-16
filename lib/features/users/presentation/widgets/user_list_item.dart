import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.email),
        leading: CircleAvatar(
          child: Text(user.name[0]),
        ),
      ),
    );
  }
}
