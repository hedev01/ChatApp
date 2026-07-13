
import '../../models/message_model.dart';

abstract class ChatRemoteDataSource {
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
  Stream<List<Object?>> get conversationRead;
  Stream<String> get userTyping;
  Stream<String> get userStopTyping;
}
