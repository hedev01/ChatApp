import 'package:chat_app/features/download/domain/repositories/download_repository.dart';

class IsDownloadedUseCase {

  final DownloadRepository repository;

  IsDownloadedUseCase(this.repository);

  Future<bool> call(String fileName) {

    return repository.isDownloaded(fileName);

  }

}