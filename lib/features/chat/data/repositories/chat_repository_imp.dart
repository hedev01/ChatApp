import 'package:chat_app/features/chat/data/datasources/remote/chat_remote_data_source.dart';
import 'package:chat_app/features/chat/domain/entities/get_user_entity.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

import '../models/message_model.dart';

class ChatRepositoryImp extends ChatRepository {
  final ChatRemoteDataSource remote;
  ChatRepositoryImp(this.remote);
  @override
  Future<GetUserEntity> getUsers(String userId)  {
    return  remote.getUsers(userId);
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
    return remote.send(
      MessageModel(
        senderId: message.senderId,
        receiverId: message.receiverId,
        content: message.content,
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
}
