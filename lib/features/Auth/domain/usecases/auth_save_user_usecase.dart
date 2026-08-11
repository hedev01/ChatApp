import 'package:chat_app/features/Auth/domain/entities/auth_entity.dart';
import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';

class AuthSaveUserUsecase {
  final AuthRepository repository;
  AuthSaveUserUsecase(this.repository);

  Future<void> call(AuthDataEntity user) {
    return repository.saveUser(user);
  }
}