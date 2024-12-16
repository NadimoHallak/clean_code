import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsers getUsers;

  UsersBloc({required this.getUsers}) : super(UsersInitial()) {
    on<GetUsersEvent>((event, emit) async {
      emit(UsersLoading());
      
      final result = await getUsers(const NoParams());
      
      if (result.isSuccess && result.data != null) {
        emit(UsersLoaded(users: result.data!));
      } else {
        emit(UsersError(message: result.error?.message ?? 'حدث خطأ غير متوقع'));
      }
    });
  }
}
