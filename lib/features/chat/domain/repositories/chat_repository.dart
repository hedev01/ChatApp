import 'package:chat_app/features/chat/domain/entities/get_user_entity.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<GetUserEntity> getUsers(String userId);
  Future<void> connect(String userId);
  Future<void> send(MessageEntity message);
  Stream<MessageEntity> getMessages();
  Future<void> stop();
  Future<void> markAsRead(String senderId);
  Stream<Set<String>> online();
  Stream<Set<String>> offline();
  Stream<List<String>> onlineUsers();
  Stream<String> read();
}
