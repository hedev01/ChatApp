import 'dart:convert';

import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/Auth/Data/models/user_model.dart';
import 'package:chat_app/features/Auth/Data/models/user_request.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSource(this.client);

  Future<UserModel> register(UserRequestModel request) async {
    final response = await http.post(
      Uri.parse("${Constans.baseUrl}/api/User/Register"),
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return UserModel.fromJson(json["Data"]);
    }
    throw Exception('Register Failed : ${response.statusCode}');
  }
}
