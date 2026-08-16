
import 'package:chat_app/features/user/data/datasources/remote/user_remote_data_source.dart';
import 'package:chat_app/features/user/domain/entity/get_user_entity.dart';
import 'package:chat_app/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImp extends UserRepository {
  final UserRemoteDataSource remote;

  UserRepositoryImp(this.remote);
  @override
  Future<GetUserEntity> getUsers({required String userId}) {
    return remote.getUsers(userId: userId);
  }

}
