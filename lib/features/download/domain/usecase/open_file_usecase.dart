import 'package:chat_app/features/download/domain/repositories/download_repository.dart';

class OpenFileUseCase {

  final DownloadRepository repository;

  OpenFileUseCase(this.repository);

  Future<void> call(String fileName) {

    return repository.openFile(fileName);

  }

}