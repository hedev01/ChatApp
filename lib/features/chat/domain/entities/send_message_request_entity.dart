class SendMessageRequestEntity {
  final String senderId;
  final String receiverId;
  final String content;

  SendMessageRequestEntity({
    required this.senderId,
    required this.receiverId,
    required this.content,
  });
}
