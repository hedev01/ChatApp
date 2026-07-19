abstract class DownloadLocalDataSource {

  Future<String> getFilePath(String fileName);

  Future<void> openFile(String fileName);

  Future<bool> exists(String fileName);
}