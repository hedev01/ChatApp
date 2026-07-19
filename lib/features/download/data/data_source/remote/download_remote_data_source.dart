abstract class DownloadRemoteDataSource {
  Future<void> download({
    required String url,
    required String savePath,
    required void Function(double progress) onProgress,
  });
}