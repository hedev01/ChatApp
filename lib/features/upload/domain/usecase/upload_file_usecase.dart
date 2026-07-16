import 'package:chat_app/features/upload/domain/entity/upload_file_entity.dart';
import 'package:chat_app/features/upload/domain/repositories/upload_file_repository.dart';

class UploadFileUsecase {
  final UploadFileRepository repository;
  UploadFileUsecase(this.repository);
  
  Future<String> call(UploadFileEntity entity){
    return repository.upload(entity);
  }
}