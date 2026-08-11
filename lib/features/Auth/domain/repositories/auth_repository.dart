import 'package:chat_app/features/Auth/domain/entities/auth_entity.dart';
import 'package:chat_app/features/Auth/domain/entities/register_request_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity?> register(RegisterRequestEntity request);
  Future<AuthEntity> login(String email, String password);
  Future<void> saveUser(AuthDataEntity user);
  Future<AuthDataEntity> getUser();
  Future<void> delete();
  Future<void> updateAvatar(String avatarUrl);
}
