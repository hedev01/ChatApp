import 'package:chat_app/features/upload/data/datasource/remote/upload_file_data_source.dart';
import 'package:chat_app/features/upload/data/models/upload_file_model.dart';
import 'package:chat_app/features/upload/domain/entity/upload_file_entity.dart';
import 'package:chat_app/features/upload/domain/repositories/upload_file_repository.dart';

class UploadFileRepositoryImp extends UploadFileRepository {
  final UploadFileDataSource remote;
  UploadFileRepositoryImp(this.remote);
  @override
  Future<String> upload(UploadFileEntity entity) {
    return remote.uploadFile(UploadFileModel.fromEntity(entity));
  }
}
