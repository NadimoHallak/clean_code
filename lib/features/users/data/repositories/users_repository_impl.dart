import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasources/users_local_data_source.dart';
import '../datasources/users_remote_data_source.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;
  final UsersLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UsersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<UseCaseResult<List<User>>> getUsers() async {
    if (await networkInfo.isConnected) {
      try {
        // جلب البيانات من API
        final remoteUsers = await remoteDataSource.getUsers();
        // تخزين البيانات محلياً
        await localDataSource.cacheUsers(remoteUsers);
        return UseCaseResult.success(remoteUsers);
      } on ServerException {
        // محاولة جلب البيانات المخزنة محلياً في حالة فشل API
        try {
          final localUsers = await localDataSource.getLastUsers();
          return UseCaseResult.success(localUsers);
        } on CacheException {
          return UseCaseResult.failure(ServerFailure());
        }
      }
    } else {
      // محاولة جلب البيانات المخزنة محلياً عند عدم وجود إنترنت
      try {
        final localUsers = await localDataSource.getLastUsers();
        return UseCaseResult.success(localUsers);
      } on CacheException {
        return UseCaseResult.failure(NetworkFailure());
      }
    }
  }
}
