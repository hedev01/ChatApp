import 'package:chat_app/core/helper/helper.dart';
import 'package:chat_app/features/chat/data/datasources/remote/chat_remote_data_source.dart';
import 'package:chat_app/features/chat/domain/entities/get_user_entity.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

import '../models/message_model.dart';

class ChatRepositoryImp extends ChatRepository {
  final ChatRemoteDataSource remote;
  ChatRepositoryImp(this.remote);
  @override
  Future<GetUserEntity> getUsers(String userId) {
    return remote.getUsers(userId);
  }

  @override
  Future<void> connect(String userId) {
    return remote.connect(userId);
  }

  @override
  Stream<MessageEntity> getMessages() {
    return remote.messages;
  }

  @override
  Future<void> send(MessageEntity message) {
    final now = DateTime.now();
    return remote.send(
      MessageModel(
        senderId: message.senderId,
        receiverId: message.receiverId,
        content: message.content,
        isRead: false,
        sentAt: now,
        sentAtTime: Helper.convertDateTimeToTime(now.toIso8601String()),
      ),
    );
  }

  @override
  Future<void> stop() {
    return remote.stop();
  }

  @override
  Stream<Set<String>> offline() {
    return remote.offline;
  }

  @override
  Stream<Set<String>> online() {
    return remote.online;
  }

  @override
  Stream<List<String>> onlineUsers() {
    return remote.onlineUsers;
  }

  @override
  Stream<String> read() {
    return remote.conversationRead;
  }

  @override
  Future<void> markAsRead(String senderId) {
    return remote.markAsRead(senderId);
  }

  @override
  Stream<String> userIsTyping() {
    return remote.userTyping;
  }

  @override
  Stream<String> userStopTyping() {
    return remote.userStopTyping;
  }

  @override
  Future<void> startTyping(String receiverId) {
    return remote.startTyping(receiverId);
  }

  @override
  Future<void> stopTyping(String receiverId) {
    return remote.stopTyping(receiverId);
  }
}
