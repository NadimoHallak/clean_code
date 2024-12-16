

class Failure {
  final String message;
  
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super('حدث خطأ في الخادم');
}

class NetworkFailure extends Failure {
  NetworkFailure() : super('لا يوجد اتصال بالإنترنت');
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure() : super('حدث خطأ غير متوقع');
}
