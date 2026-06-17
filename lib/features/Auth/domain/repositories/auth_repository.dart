import 'package:chat_app/features/Auth/domain/entities/register_request_entity.dart';
import 'package:chat_app/features/Auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> register(RegisterRequestEntity request);
  Future<UserEntity> login(String email , String password);
  Future<void> saveUser(UserDataEntity user);
  Future<UserDataEntity> getUser();
}
