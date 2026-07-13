import 'package:chat_app/features/Auth/Data/datasources/remote/auth_remote_data_source.dart';
import 'package:chat_app/features/Auth/Data/models/user_request.dart';
import 'package:chat_app/features/Auth/domain/entities/register_request_entity.dart';
import 'package:chat_app/features/user/domain/entity/user_entity.dart';
import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImp(this.remote,);
  @override
  Future<UserEntity?> register(RegisterRequestEntity request) async {
    return await remote.register(
      UserRequestModel.fromEntity(request)
    );
  }

  
  @override
  Future<UserEntity> login(String email, String password)async {
   return await remote.login(email, password);
  }
}
