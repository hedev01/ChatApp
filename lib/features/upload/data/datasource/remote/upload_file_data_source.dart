import 'package:chat_app/features/upload/data/models/upload_file_model.dart';

abstract class UploadFileDataSource {
  Future<String> uploadFile(UploadFileModel model);
}
