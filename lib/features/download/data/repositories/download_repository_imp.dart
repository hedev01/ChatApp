import 'package:chat_app/features/download/data/data_source/local/download_local_data_source.dart';
import 'package:chat_app/features/download/data/data_source/remote/download_remote_data_source.dart';
import 'package:chat_app/features/download/domain/repositories/download_repository.dart';

class DownloadRepositoryImp implements DownloadRepository {
  final DownloadRemoteDataSource remote;
  final DownloadLocalDataSource local;

  DownloadRepositoryImp(this.remote, this.local);

  @override
  Future<void> downloadFile({
    required String url,
    required String fileName,
    required void Function(double progress) onProgress,
  }) async {
    final path = await local.getFilePath(fileName);

    await remote.download(url: url, savePath: path, onProgress: onProgress);
  }

  @override
  Future<void> openFile(String fileName) {
    return local.openFile(fileName);
  }

  @override
  Future<bool> isDownloaded(String fileName) {
    return local.exists(fileName);
  }
}
