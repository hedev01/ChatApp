import 'package:chat_app/features/Auth/Data/models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(AuthDataModel user);
  Future<AuthDataModel> getUser();
  Future<void> delete();
  Future<void> updateAvatar(String avatarUrl);
}
