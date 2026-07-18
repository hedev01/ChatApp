import 'package:chat_app/core/enums/messages_type.dart';
import 'package:signalr_netcore/ihub_protocol.dart';

class MessageEntity {
  final String senderId;
  final String receiverId;
  final String content;
  final bool isRead;
  final DateTime sentAt;
  final String sentAtTime;
  final MessagesType type;
  final String? fileUrl;
  final String? fileName;
  final int? fileSize;
  MessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.isRead,
    required this.sentAt,
    required this.sentAtTime,
     this.type = MessagesType.text,
     this.fileUrl,
     this.fileName,
     this.fileSize
  });

  MessageEntity copyWith({
    String? senderId,
    String? receiverId,
    String? content,
    bool? isRead,
    DateTime? sentAt,
    String? sentAtTime,
    MessagesType? type,
    String? fileUrl,
    String? fileName,
    int? fileSize
  }) {
    return MessageEntity(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      sentAt: sentAt ?? this.sentAt,
      sentAtTime: sentAtTime ?? this.sentAtTime,
      type: type ?? this.type,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize
    );
  }
}
