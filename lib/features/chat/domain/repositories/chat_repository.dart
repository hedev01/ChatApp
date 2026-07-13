import 'package:chat_app/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<void> connect(String userId);
  Future<void> send(MessageEntity message);
  Stream<MessageEntity> getMessages();
  Future<void> stop();
  Future<void> markAsRead(String senderId);
  Stream<Set<String>> online();
  Stream<Set<String>> offline();
  Stream<List<String>> onlineUsers();
  Stream<List<Object?>> read();
  Stream<String> userIsTyping();
  Stream<String> userStopTyping();
  Future<void> startTyping(String receiverId);
  Future<void> stopTyping(String receiverId);
}
