import 'package:chat_app/features/profile/domain/entities/upload_avatar_entity.dart';

abstract class ProfileRepository {
  Future<String> uploadAvatar(UploadAvatarEntity upload);
}
