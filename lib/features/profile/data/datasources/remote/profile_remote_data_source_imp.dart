import 'dart:async';

import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:chat_app/features/profile/data/models/upload_avatar_model.dart';
import 'package:http/http.dart' as http;

class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  @override
  Future<String> uploadAvatar(UploadAvatarModel upload) async {
    String? avatarUrl;

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("${Constans.baseUrl}/api/User/avatar"),
      );

      request.fields["userId"] = upload.userId;

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          upload.file.path,
          filename: upload.file.path.split("/").last,
        ),
      );
      final response = await request.send().timeout(
        Duration(seconds: Constans.timeOut),
      );

      final body = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        avatarUrl = body;
      }
      return avatarUrl!;
    } on TimeoutException {
      throw TimeoutException("/api/User/avatar ==>>> Time Out");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
