import 'package:chat_app/features/Auth/domain/entities/register_request_entity.dart';
import 'package:chat_app/features/user/domain/entity/user_entity.dart';
import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;
  const AuthUseCase(this.repository);

  Future<UserEntity?> register(RegisterRequestEntity request) {
    return repository.register(request);
  }


  Future<UserEntity> login(String email, String password) {
    return repository.login(email, password);
  }
}
