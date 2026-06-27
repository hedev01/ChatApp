import 'package:chat_app/features/chat/data/models/get_user_model.dart';

abstract class ChatRemoteDataSource {
  Future<GetUserModel> getUsers(String userId);
}
