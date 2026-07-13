import 'dart:async';
import 'dart:convert';

import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/user/data/datasources/remote/user_remote_data_source.dart';
import 'package:chat_app/features/user/data/models/get_user_model.dart';
import 'package:http/http.dart' as http;
class UserRemoteDataSourceImp extends UserRemoteDataSource {
  @override
  Future<GetUserModel> getUsers(String userId) async {
    GetUserModel? data;
    try {
      final response = await http
          .get(
            Uri.parse("${Constans.baseUrl}/api/User/GetUsers?userId=$userId"),
          )
          .timeout(Duration(seconds: Constans.timeOut));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        data = GetUserModel.fromJson(json);
      }
    } on TimeoutException {
      throw TimeoutException(
        "Api: ${Constans.baseUrl}/api/User/GetUsers?userId=$userId =>> TimeOut",
      );
    }
    return data!;
  }
}
