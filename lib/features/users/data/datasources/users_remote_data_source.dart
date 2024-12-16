import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UsersRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final Dio dio;

  UsersRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/users');
      
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((user) => UserModel.fromJson(user))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
