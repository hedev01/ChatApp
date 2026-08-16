import 'package:chat_app/features/user/data/models/get_user_model.dart';

abstract class UserRemoteDataSource {
  Future<GetUserModel> getUsers({required String userId});
}
