import 'dart:async';
import 'dart:convert';

import 'package:chat_app/features/Auth/Data/datasources/remote/auth_remote_data_source.dart';

import '../../../../../core/constans/constans.dart';
import '../../models/user_model.dart';
import '../../models/user_request.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  @override
  Future<UserModel?> register(UserRequestModel request) async {
    try {
      final response = await http
          .post(
            Uri.parse("${Constans.baseUrl}/api/User/Register"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(request.toJson()),
          )
          .timeout(Duration(seconds: Constans.timeOut));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return UserModel.fromJson(json);
      }
    } on TimeoutException {
      throw TimeoutException(
        "${Constans.baseUrl}/api/User/Register"
        " TimeOut Exception",
      );
    } catch (e) {
      throw Exception('Register Failed : $e');
    }
    return null;
  }

  @override
  Future<UserModel> login(String email, String password) async {
    UserModel? result;

    try {
      final response = await http
          .post(
            Uri.parse("${Constans.baseUrl}/api/User/Login"),
            headers: {"Content-Type": "application/json"},

            body: jsonEncode({
              "email": email, "password": password,
            }),
          )
          .timeout(Duration(seconds: Constans.timeOut));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        result = UserModel.fromJson(json);
      }
    } on TimeoutException {
      throw TimeoutException(
        "${Constans.baseUrl}/api/User/Login"
        " TimeOut Exception",
      );
    } catch (e) {
      throw Exception('Login Failed : $e');
    }
    return result!;
  }
}
