import 'package:chat_app/features/download/domain/repositories/download_repository.dart';

class DownloadUsecase {
  final DownloadRepository repository;

  DownloadUsecase(this.repository);

  Future<void> call({
    required String url,
    required String fileName,
    required void Function(double progress) onProgress,
  }) {
    return repository.downloadFile(
      url: url,
      fileName: fileName,
      onProgress: onProgress,
    );
  }
}
