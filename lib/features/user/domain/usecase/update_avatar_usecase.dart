import 'package:chat_app/features/profile/data/repositories/profile_repository_imp.dart';
import 'package:chat_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:chat_app/features/user/domain/repositories/user_repository.dart';

class UpdateAvatarUsecase {
  final UserRepository repository;
  UpdateAvatarUsecase(this.repository);

  Future<void> call(String avatarUrl){
    return repository.updateAvatar(avatarUrl);
  }
}