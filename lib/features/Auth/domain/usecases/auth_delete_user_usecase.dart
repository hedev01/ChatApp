import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';

class AuthDeleteUserUsecase {
  final AuthRepository repository;
  AuthDeleteUserUsecase(this.repository);

  Future<void> call() {
    return repository.delete();
  }
}