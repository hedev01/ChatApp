import 'dart:io';


enum UploadFileStatus { initial, loading, success, failure }

class UploadFileState {
  final UploadFileStatus status;
  final File? file;
  final String? fileUrl;
  final String? error;

  UploadFileState({
    this.status = UploadFileStatus.initial,
    this.file,
    this.fileUrl,
    this.error,
  });

  UploadFileState copyWith(
    {UploadFileStatus? status,
    File? file,
    String? fileUrl,
    String? error,}
  ) {
    return UploadFileState(
      status: status ?? this.status,
      file: file ?? this.file,
      fileUrl: fileUrl ?? this.fileUrl,
      error: error ?? this.error,
    );
  }
}
