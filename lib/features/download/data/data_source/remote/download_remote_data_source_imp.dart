import 'package:chat_app/features/download/data/data_source/remote/download_remote_data_source.dart';
import 'package:dio/dio.dart';

class DownloadRemoteDataSourceImpl
    implements DownloadRemoteDataSource {

  final Dio dio;

  DownloadRemoteDataSourceImpl(this.dio);

  @override
  Future<void> download({
    required String url,
    required String savePath,
    required void Function(double progress) onProgress,
  }) async {
    await dio.download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total > 0) {
          onProgress(received / total);
        }
      },
    );
  }
}