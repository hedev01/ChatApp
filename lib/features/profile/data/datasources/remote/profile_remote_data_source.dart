import 'package:chat_app/features/profile/data/models/upload_avatar_model.dart';

abstract class ProfileRemoteDataSource {
  Future<String> uploadAvatar(UploadAvatarModel upload);
}