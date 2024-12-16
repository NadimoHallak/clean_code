import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<UseCaseResult<Type>> call(Params params);
}

class UseCaseResult<T> {
  final T? data;
  final Failure? error;
  
  UseCaseResult.success(this.data) : error = null;
  UseCaseResult.failure(this.error) : data = null;
  
  bool get isSuccess => error == null;
  bool get isFailure => error != null;
}

class NoParams {
  const NoParams();
}
