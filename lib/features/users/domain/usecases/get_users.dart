
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/users_repository.dart';

class GetUsers implements UseCase<List<User>, NoParams> {
  final UsersRepository repository;

  GetUsers(this.repository);

  @override
  Future<UseCaseResult<List<User>>> call(NoParams params) async {
    return await repository.getUsers();
  }
}
