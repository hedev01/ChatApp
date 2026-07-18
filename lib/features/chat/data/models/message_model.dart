import 'dart:math';

import 'package:chat_app/core/enums/messages_type.dart';
import 'package:chat_app/core/helper/helper.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:signalr_netcore/ihub_protocol.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.senderId,
    required super.receiverId,
    required super.content,
    required super.isRead,
    required super.sentAt,
    required super.sentAtTime,
    super.type,
    super.fileUrl,
    super.fileName,
    super.fileSize,
  });

  factory MessageModel.fromHub(List<Object?> args) {
    final json = Map<String, dynamic>.from(args.first as Map);

    final date = DateTime.parse(json["sentAt"]).toLocal();

    return MessageModel(
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      content: json["content"],
      fileUrl: json["fileUrl"],
      fileName: json["fileName"],
      fileSize: json["fileSize"],
      type: MessagesType.values.firstWhere(
        (e) => e.name.toLowerCase() == json["type"].toString().toLowerCase(),
      ),
      sentAt: date,
      sentAtTime: Helper.convertDateTimeToTime(date.toIso8601String()),
      isRead: false,
    );
  }

  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      senderId: entity.senderId,
      receiverId: entity.receiverId,
      content: entity.content,
      isRead: entity.isRead,
      sentAt: entity.sentAt,
      sentAtTime: entity.sentAtTime,
      type: entity.type,
      fileName: entity.fileName,
      fileSize: entity.fileSize,
      fileUrl: entity.fileUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "content": content,
      "type": type.name,
      "fileUrl": fileUrl ?? '',
      "fileName": fileName ?? '',
      "fileSize": fileSize ?? 0,
    };
  }
}
