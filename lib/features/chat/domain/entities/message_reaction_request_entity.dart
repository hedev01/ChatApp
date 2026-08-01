import 'package:chat_app/core/enums/reaction_type.dart';

class MessageReactionRequestEntity {
  final int messageId;
  final int userId;
  final String senderId;
  final String receiverId;
  final ReactionType reaction;
  MessageReactionRequestEntity({
    required this.messageId,
    required this.userId,
    required this.senderId,
    required this.receiverId,
    required this.reaction,
  });
}
