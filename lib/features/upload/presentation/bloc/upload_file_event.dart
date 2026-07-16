import 'package:chat_app/features/upload/domain/entity/upload_file_entity.dart';

abstract class UploadFileEvent {}

class Uploaded extends UploadFileEvent{
  final UploadFileEntity entity;
  Uploaded({required this.entity});
}