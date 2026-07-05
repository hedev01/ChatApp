class MessageEntity {
  final String senderId;
  final String receiverId;
  final String content;
  final bool isRead;

  MessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.isRead
  });

  MessageEntity copyWith({
    String? senderId,
    String? receiverId,
    String? content,
    bool? isRead
  }) {
    return MessageEntity(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead
    );
  }
}