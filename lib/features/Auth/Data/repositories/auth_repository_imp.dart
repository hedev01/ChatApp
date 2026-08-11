import 'package:chat_app/features/Auth/Data/datasources/local/auth_local_data_source.dart';
import 'package:chat_app/features/Auth/Data/datasources/remote/auth_remote_data_source.dart';
import 'package:chat_app/features/Auth/Data/models/auth_model.dart';
import 'package:chat_app/features/Auth/Data/models/user_request.dart';
import 'package:chat_app/features/Auth/domain/entities/auth_entity.dart';
import 'package:chat_app/features/Auth/domain/entities/register_request_entity.dart';
import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImp(this.remote, this.local);
  @override
  Future<AuthEntity?> register(RegisterRequestEntity request) async {
    return await remote.register(
      UserRequestModel.fromEntity(request)
    );
  }

  
  @override
  Future<AuthEntity> login(String email, String password)async {
   return await remote.login(email, password);
  }

  @override
  Future<void> delete() {
    return local.delete();
  }

  @override
  Future<AuthDataEntity> getUser() {
    return local.getUser();
  }

  @override
  Future<void> saveUser(AuthDataEntity user) {
    return local.saveUser(AuthDataModel.fromEntity(user));
  }

  @override
  Future<void> updateAvatar(String avatarUrl) {
    return local.updateAvatar(avatarUrl);
  }
}
