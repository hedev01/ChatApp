import 'package:chat_app/features/upload/domain/entity/upload_file_entity.dart';

abstract class UploadFileRepository {
  Future<String> upload(UploadFileEntity entity);
}
