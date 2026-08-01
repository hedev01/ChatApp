import 'package:chat_app/features/chat/data/models/message_reaction_request_model.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/entities/message_reaction_entity.dart';
import 'package:chat_app/features/chat/domain/entities/message_reaction_request_entity.dart';

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
  Stream<MessageReactionEntity> getReaction();
  Future<void> startTyping(String receiverId);
  Future<void> stopTyping(String receiverId);
  Future<void> sendReaction(MessageReactionRequestEntity entity);
}
