import 'package:chat_app/features/upload/domain/entity/upload_file_entity.dart';

class UploadFileModel extends UploadFileEntity {
  UploadFileModel({required super.file, required super.userId , required super.folderName});

  factory UploadFileModel.fromEntity(UploadFileEntity entity){
    return UploadFileModel(file: entity.file, userId: entity.userId, folderName: entity.folderName);
  }
}