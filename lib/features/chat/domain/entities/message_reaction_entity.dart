import 'package:chat_app/core/enums/reaction_type.dart';

class MessageReactionEntity {
  final int userId;
  final int messageId;
  final ReactionType reaction;
  MessageReactionEntity({
    required this.userId,
    required this.messageId,
    required this.reaction,
  });
}
