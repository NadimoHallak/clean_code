import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/users_bloc.dart';
import '../widgets/user_list_item.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المستخدمين'),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersInitial) {
            context.read<UsersBloc>().add(GetUsersEvent());
            return const Center(child: Text('ابدأ'));
          } else if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return UserListItem(user: user);
              },
            );
          } else if (state is UsersError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
