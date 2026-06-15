import 'dart:async';
import 'dart:convert';

import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/Auth/Data/models/user_model.dart';
import 'package:chat_app/features/Auth/Data/models/user_request.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> register(UserRequestModel request);
}
