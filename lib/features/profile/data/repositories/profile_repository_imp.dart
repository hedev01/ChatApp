import 'package:chat_app/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:chat_app/features/profile/data/models/upload_avatar_model.dart';
import 'package:chat_app/features/profile/domain/entities/upload_avatar_entity.dart';
import 'package:chat_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImp implements ProfileRepository {
  final ProfileRemoteDataSource remote;
  ProfileRepositoryImp(this.remote);
  @override
  Future<String> uploadAvatar(UploadAvatarEntity upload) {
    return remote.uploadAvatar(UploadAvatarModel.fromEntity(upload));
  }
}
