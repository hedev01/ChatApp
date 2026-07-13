import 'dart:async';
import 'package:chat_app/features/user/data/models/user_model.dart';
import 'package:chat_app/features/Auth/Data/models/user_request.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> register(UserRequestModel request);
  Future<UserModel> login(String email, String password);
}
