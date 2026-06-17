import 'package:chat_app/features/Auth/Data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserDataModel user);
  Future<UserDataModel> getUser();
}