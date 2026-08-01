import 'package:chat_app/core/enums/reaction_type.dart';
import 'package:chat_app/core/extension/reaction_type_parser.dart';
import 'package:chat_app/features/chat/domain/entities/message_reaction_entity.dart';

class MessageReactionModel extends MessageReactionEntity {
  MessageReactionModel({
    required super.userId,
    required super.messageId,
    required super.reaction,
  });

  factory MessageReactionModel.fromJson(Map<String, dynamic> json) {
    return MessageReactionModel(
      userId: json['userId'],
      messageId: json['messageId'],
      reaction: ReactionType.values.firstWhere(
        (e) => e.name == json['reaction'],
      ),
    );
  }

  factory MessageReactionModel.fromhub(List<Object?>? args) {
    final json = Map<String, dynamic>.from(args!.first as Map);
    return MessageReactionModel(
      userId: json['userId'],
      messageId: json['messageId'],
      reaction: ReactionTypeParser.fromString(json['reaction']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "messageId": messageId,
      "reaction": reaction.name,
    };
  }
}
