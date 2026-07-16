import 'package:chat_app/features/user/data/datasources/local/user_local_data_source.dart';
import 'package:chat_app/features/user/data/models/user_model.dart';
import 'package:chat_app/features/user/domain/entity/user_entity.dart';
import 'package:chat_app/features/user/data/datasources/remote/user_remote_data_source.dart';
import 'package:chat_app/features/user/domain/entity/get_user_entity.dart';
import 'package:chat_app/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImp extends UserRepository {
  final UserRemoteDataSource remote;
  final UserLocalDataSource local;

  UserRepositoryImp(this.remote, this.local);
  @override
  Future<GetUserEntity> getUsers(String userId) {
    return remote.getUsers(userId);
  }

  @override
  Future<UserDataEntity> getUser() {
    return local.getUser();
  }

  @override
  Future<void> saveUser(UserDataEntity user) {
    return local.saveUser(UserDataModel.fromEntity(user));
  }

  @override
  Future<void> delete() {
    return local.delete();
  }
  
  @override
  Future<void> updateAvatar(String avatarUrl) {
   return local.updateAvatar(avatarUrl);
  }
}
