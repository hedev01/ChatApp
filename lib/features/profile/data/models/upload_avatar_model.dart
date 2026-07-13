import 'package:chat_app/features/profile/domain/entities/upload_avatar_entity.dart';

class UploadAvatarModel extends UploadAvatarEntity {
  UploadAvatarModel({required super.file, required super.userId});

  factory UploadAvatarModel.fromEntity(UploadAvatarEntity entity) {
    return UploadAvatarModel(file: entity.file, userId: entity.userId);
  }
}
