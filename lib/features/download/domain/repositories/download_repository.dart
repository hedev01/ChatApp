abstract class DownloadRepository {
  Future<void> downloadFile({
    required String url,
    required String fileName,
    required void Function(double progress) onProgress,
  });

  Future<void> openFile(String fileName);

  Future<bool> isDownloaded(String fileName);
}