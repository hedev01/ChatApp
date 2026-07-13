import 'package:chat_app/features/profile/domain/entities/upload_avatar_entity.dart';
import 'package:chat_app/features/profile/domain/repositories/profile_repository.dart';

class UploadAvatarUsecase {
  final ProfileRepository repository;
  UploadAvatarUsecase(this.repository);
  Future<String> call(UploadAvatarEntity upload) {
    return repository.uploadAvatar(upload);
  }
}
