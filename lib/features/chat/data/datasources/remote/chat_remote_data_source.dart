import 'package:chat_app/features/chat/data/models/get_user_model.dart';

import '../../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<GetUserModel> getUsers(String userId);
  Future<void> connect(String userId);

  Future<void> send(MessageModel message);

  Stream<MessageModel> get messages;
  Future<void> stop();
}
