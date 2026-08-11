import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';

class AuthUpdateAvatarUsecase {
  final AuthRepository repository;
  AuthUpdateAvatarUsecase(this.repository);
  Future<void> call(String avatarUrl) {
    return repository.updateAvatar(avatarUrl);
  }
}