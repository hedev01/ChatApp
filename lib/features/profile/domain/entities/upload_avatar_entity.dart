import 'dart:io';

class UploadAvatarEntity {
  final File file;
  final String userId;

  UploadAvatarEntity({required this.file, required this.userId});
  
}
