import 'package:chat_app/core/helper/helper.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.senderId,
    required super.receiverId,
    required super.content,
    required super.isRead,
    required super.sentAt,
    required super.sentAtTime
  });

  factory MessageModel.fromHub(List<Object?> args) {
    final date = DateTime.parse(args[3].toString()).toLocal();

    return MessageModel(
      senderId: args[0].toString(),
      receiverId: args[1].toString(),
      content: args[2].toString(),
      sentAt: date,
      sentAtTime: Helper.convertDateTimeToTime(date.toIso8601String()),
      isRead: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "content": content,
    };
  }
}
