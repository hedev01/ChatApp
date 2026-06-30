import 'package:chat_app/features/chat/data/models/get_user_model.dart';

import '../../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<GetUserModel> getUsers(String userId);
  Future<void> connect(String userId);

  Future<void> send(MessageModel message);

  Stream<MessageModel> get messages;
  Stream<Set<String>> get online;
  Stream<Set<String>> get offline; 
  Stream<List<String>> get onlineUsers;
  Future<void> stop();
}
