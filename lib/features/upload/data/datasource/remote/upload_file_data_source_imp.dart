import 'dart:async';
import 'dart:convert';

import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/upload/data/datasource/remote/upload_file_data_source.dart';
import 'package:chat_app/features/upload/data/models/upload_file_model.dart';
import 'package:http/http.dart' as http;

class UploadFileDataSourceImp implements UploadFileDataSource {
  @override
  Future<String> uploadFile(UploadFileModel model)async {
      String? avatarUrl;

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("${Constans.baseUrl}/api/Upload"),
      );

      request.fields["userId"] = model.userId;

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          model.file.path,
          filename: model.file.path.split("/").last,
        ),
      );
      final response = await request.send().timeout(
        Duration(seconds: Constans.timeOut),
      );

      final body = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final response = jsonDecode(body);
        
        avatarUrl = response["avatarUrl"];
      }
      return avatarUrl!;
    } on TimeoutException {
      throw TimeoutException("/api/Upload ==>>> Time Out");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}