import 'package:chat_app/features/user/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser(UserDataModel user);
  Future<UserDataModel> getUser();
  Future<void> delete();
  Future<void> updateAvatar(String avatarUrl);
}