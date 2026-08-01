import 'package:chat_app/core/enums/reaction_type.dart';
import 'package:chat_app/features/chat/domain/entities/message_reaction_request_entity.dart';

class MessageReactionRequestModel extends MessageReactionRequestEntity {
  MessageReactionRequestModel({
    required super.messageId,
    required super.userId,
    required super.senderId,
    required super.receiverId,
    required super.reaction,
  });

  factory MessageReactionRequestModel.fromJson(Map<String, dynamic> json) {
    return MessageReactionRequestModel(
      messageId: json['messageId'],
      userId: json['userId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      reaction: ReactionType.values.firstWhere(
        (e) =>
            e.name.toLowerCase() == json['reaction'].toString().toLowerCase(),
      ),
    );
  }
  factory MessageReactionRequestModel.fromEntity(
    MessageReactionRequestEntity entity,
  ) {
    return MessageReactionRequestModel(
      messageId: entity.messageId,
      userId: entity.userId,
      senderId: entity.senderId,
      receiverId: entity.receiverId,
      reaction: entity.reaction,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "messageId": messageId,
      "userId": userId,
      "senderId": senderId,
      "receiverId": receiverId,
      "reaction": reaction.name,
    };
  }
}
