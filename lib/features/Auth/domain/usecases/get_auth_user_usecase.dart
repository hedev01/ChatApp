import 'package:chat_app/features/Auth/domain/entities/auth_entity.dart';
import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';

class GetAuthUserUsecase {
  final AuthRepository repository;
  GetAuthUserUsecase(this.repository);
  Future<AuthDataEntity> call() {
    return repository.getUser();
  }
}
