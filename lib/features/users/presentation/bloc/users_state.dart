part of 'users_bloc.dart';

abstract class UsersState {
  const UsersState();
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;

  const UsersLoaded({required this.users});
}

class UsersError extends UsersState {
  final String message;

  const UsersError({required this.message});
}
