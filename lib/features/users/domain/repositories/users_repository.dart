
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';

abstract class UsersRepository {
  Future<UseCaseResult<List<User>>> getUsers();
}
