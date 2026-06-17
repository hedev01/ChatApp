import 'package:chat_app/features/Auth/Data/datasources/local/auth_local_data_source.dart';
import 'package:chat_app/features/Auth/Data/datasources/remote/auth_remote_data_source.dart';
import 'package:chat_app/features/Auth/Data/models/user_model.dart';
import 'package:chat_app/features/Auth/Data/models/user_request.dart';
import 'package:chat_app/features/Auth/Data/datasources/local/auth_local_data_source_imp.dart';
import 'package:chat_app/features/Auth/domain/entities/register_request_entity.dart';
import 'package:chat_app/features/Auth/domain/entities/user_entity.dart';
import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImp(this.remote, this.local);
  @override
  Future<UserEntity?> register(RegisterRequestEntity request) async {
    return await remote.register(
      UserRequestModel.fromEntity(request)
    );
  }

  @override
  Future<void> saveUser(UserDataEntity user) async {
    return await local.saveUser(
      UserDataModel.fromEntity(user)
    );
  }
  
  @override
  Future<UserDataEntity> getUser() async{
    return await local.getUser();
  }
  
  @override
  Future<UserEntity> login(String email, String password)async {
   return await remote.login(email, password);
  }
}
