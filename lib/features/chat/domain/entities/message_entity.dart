class MessageEntity {
  final String senderId;
  final String receiverId;
  final String content;
  final bool isRead;
  final DateTime sentAt;
  final String sentAtTime;
  MessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.isRead,
    required this.sentAt,
    required this.sentAtTime
  });

  MessageEntity copyWith({
    String? senderId,
    String? receiverId,
    String? content,
    bool? isRead,
    DateTime? sentAt,
    String? sentAtTime
  }) {
    return MessageEntity(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      sentAt: sentAt ?? this.sentAt,
      sentAtTime: sentAtTime ?? this.sentAtTime
    );
  }
}
