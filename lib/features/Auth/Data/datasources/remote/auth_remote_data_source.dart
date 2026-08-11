import 'dart:async';
import 'package:chat_app/features/Auth/Data/models/auth_model.dart';
import 'package:chat_app/features/Auth/Data/models/user_request.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel?> register(UserRequestModel request);
  Future<AuthModel> login(String email, String password);
}
