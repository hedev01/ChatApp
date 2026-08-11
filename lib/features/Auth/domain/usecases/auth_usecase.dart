import 'package:chat_app/features/Auth/domain/entities/auth_entity.dart';
import 'package:chat_app/features/Auth/domain/entities/register_request_entity.dart';
import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;
  const AuthUseCase(this.repository);

  Future<AuthEntity?> register(RegisterRequestEntity request) {
    return repository.register(request);
  }


  Future<AuthEntity> login(String email, String password) {
    return repository.login(email, password);
  }
}
