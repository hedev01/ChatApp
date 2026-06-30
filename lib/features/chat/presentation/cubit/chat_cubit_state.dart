import '../../domain/entities/message_entity.dart';

class ChatState {
  final List<MessageEntity> messages;
  final Map<String, bool> isOnline;

  const ChatState({this.messages = const [], this.isOnline = const {}});

  ChatState copyWith({List<MessageEntity>? messages, Map<String, bool>? isOnline}) {
    return ChatState(
      messages: messages ?? this.messages,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
