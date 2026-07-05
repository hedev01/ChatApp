import '../../domain/entities/message_entity.dart';

class ChatState {
  final Map<String, List<MessageEntity>> messages;
  final Map<String, bool> isOnline;
  final Map<String, int> unreadCount;
  final Map<String, MessageEntity> lastMessages;

  const ChatState({this.messages = const {}, this.isOnline = const {} , this.unreadCount = const {} , this.lastMessages = const {}});

  ChatState copyWith({
    Map<String, List<MessageEntity>>? messages,
    Map<String, bool>? isOnline,
    Map<String, int>? unreadCount,
    Map<String, MessageEntity>? lastMessages
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isOnline: isOnline ?? this.isOnline,
      unreadCount: unreadCount ?? this.unreadCount,
      lastMessages: lastMessages ?? this.lastMessages
    );
  }
}
