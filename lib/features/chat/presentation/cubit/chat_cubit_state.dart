import '../../domain/entities/message_entity.dart';

class ChatState {
  final Map<String, List<MessageEntity>> messages;
  final Map<String, bool> isOnline;
  final Map<String, int> unreadCount;
  final Map<String, MessageEntity> lastMessages;
  final Map<String, bool> isTyping;
  final Map<String , bool> seen;

  const ChatState({
    this.messages = const {},
    this.isOnline = const {},
    this.unreadCount = const {},
    this.lastMessages = const {},
    this.isTyping = const {},
    this.seen = const {}
  });

  ChatState copyWith({
    Map<String, List<MessageEntity>>? messages,
    Map<String, bool>? isOnline,
    Map<String, int>? unreadCount,
    Map<String, MessageEntity>? lastMessages,
    Map<String, bool>? isTyping,
    Map<String , bool>? seen
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isOnline: isOnline ?? this.isOnline,
      unreadCount: unreadCount ?? this.unreadCount,
      lastMessages: lastMessages ?? this.lastMessages,
      isTyping: isTyping ?? this.isTyping,
      seen: seen ?? this.seen
    );
  }
}
