import 'dart:io';

import 'package:chat_app/features/download/data/data_source/local/download_local_data_source.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class DownloadLocalDataSourceImpl
    implements DownloadLocalDataSource {

  @override
  Future<String> getFilePath(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();

    return "${dir.path}/$fileName";
  }

  @override
  Future<void> openFile(String fileName) async {
    final path = await getFilePath(fileName);

    await OpenFilex.open(path);
  }

  @override
  Future<bool> exists(String fileName) async {
    final path = await getFilePath(fileName);

    return File(path).exists();
  }
}