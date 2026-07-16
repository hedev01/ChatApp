import 'package:chat_app/features/user/domain/entity/get_user_entity.dart';

import '../entity/user_entity.dart';

abstract class UserRepository {
  Future<GetUserEntity> getUsers(String userId);
  Future<void> saveUser(UserDataEntity user);
  Future<UserDataEntity> getUser();
  Future<void> delete();
  Future<void> updateAvatar(String avatarUrl);
}
