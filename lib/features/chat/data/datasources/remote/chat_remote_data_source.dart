import 'package:chat_app/features/chat/data/models/get_user_model.dart';

import '../../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<GetUserModel> getUsers(String userId);
  Future<void> connect(String userId);
  Future<void> send(MessageModel message);
  Future<void> stop();
  Future<void> markAsRead(String senderId);
  Future<void> startTyping(String receiverId);
  Future<void> stopTyping(String receiverId);
  Stream<MessageModel> get messages;
  Stream<Set<String>> get online;
  Stream<Set<String>> get offline;
  Stream<List<String>> get onlineUsers;
  Stream<String> get conversationRead;
  Stream<String> get userTyping;
  Stream<String> get userStopTyping;
}
