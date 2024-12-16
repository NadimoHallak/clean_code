import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UsersLocalDataSource {
  Future<List<UserModel>> getLastUsers();
  Future<void> cacheUsers(List<UserModel> users);
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const CACHED_USERS_KEY = 'CACHED_USERS';

  UsersLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<UserModel>> getLastUsers() async {
    final jsonString = sharedPreferences.getString(CACHED_USERS_KEY);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    final List<Map<String, dynamic>> jsonList = 
        users.map((user) => user.toJson()).toList();
    await sharedPreferences.setString(
      CACHED_USERS_KEY,
      json.encode(jsonList),
    );
  }
}
