import 'dart:io';

class UploadFileEntity {
  final File file;
  final String userId;
  final String folderName;
  UploadFileEntity({required this.file, required this.userId , required this.folderName});

  
}
