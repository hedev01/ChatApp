import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/core/di/locator.dart';
import 'package:chat_app/core/enums/messages_type.dart';
import 'package:chat_app/core/enums/reaction_type.dart';
import 'package:chat_app/core/helper/helper.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/entities/message_reaction_entity.dart';
import 'package:chat_app/features/chat/domain/entities/message_reaction_request_entity.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/widgets/file_message.dart';
import 'package:chat_app/features/download/presentation/cubit/download_cubit.dart';
import 'package:chat_app/features/user/domain/entity/get_user_entity.dart';
import 'package:chat_app/global_widget/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBubble extends StatelessWidget {
  final MessageEntity message;
  final GetUserDataEntity user;
  final List<MessageReactionEntity> reactions;
  final String myUserId;

  ChatBubble({
    super.key,
    required this.message,
    required this.user,
    required this.reactions,
    required this.myUserId,
  });

  ReactionType? selectedReaction;

  @override
  Widget build(BuildContext context) {
    final isMe = message.senderId == myUserId;

    return GestureDetector(
      onLongPress: () {
        _showReactionPicker(context);
      },

      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,

        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,

          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 280),

                  margin: const EdgeInsets.symmetric(vertical: 8),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),

                  decoration: BoxDecoration(
                    color: isMe ? const Color(0xffF2F2F7) : Colors.black,

                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),

                      topRight: const Radius.circular(18),

                      bottomLeft: Radius.circular(isMe ? 18 : 0),

                      bottomRight: Radius.circular(isMe ? 0 : 18),
                    ),
                  ),

                  child: _buildMessageContent(isMe, context),
                ),

                if (reactions.isNotEmpty) _buildReactions(isMe),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),

              child: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    message.sentAtTime,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),

                  if (isMe) ...[
                    const SizedBox(width: 4),

                    Icon(
                      message.isRead ? Icons.done_all : Icons.done,

                      size: 15,

                      color: message.isRead ? Colors.blue : Colors.grey,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReactionPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.transparent,

      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(20),

          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(40),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: ReactionType.values
                .map(
                  (emoji) => GestureDetector(
                    onTap: () {
                      context.read<ChatCubit>().sendReaction(
                        MessageReactionRequestEntity(
                          messageId: message.messageId ?? 0,
                          userId: user.id,
                          senderId:  message.senderId,
                          receiverId: message.receiverId,
                          reaction: emoji,
                        ),
                      );
                      Navigator.pop(context);
                    },

                    child: Text(
                      Helper.reactionEmoji(emoji),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildMessageContent(bool isMe, BuildContext context) {
    switch (message.type) {
      case MessagesType.text:
        return Text(
          message.content,
          style: TextStyle(
            color: isMe ? Colors.black87 : Colors.white,
            fontSize: 16,
          ),
        );

      case MessagesType.image:
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullScreenImage(
                  imageUrl: Constans.baseUrl + message.fileUrl!,
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              Constans.baseUrl + message.fileUrl!,
              width: 220,
              fit: BoxFit.cover,
            ),
          ),
        );

      case MessagesType.file:
        return BlocProvider(
          create: (context) =>
              locator<DownloadCubit>()..check(message.fileName!),
          child: FileMessage(message: message, isMe: isMe),
        );
    }
  }

  Widget _buildReactions(bool isMe) {
    final Map<ReactionType, int> counts = {};

    for (final reaction in reactions) {
      counts[reaction.reaction] = (counts[reaction.reaction] ?? 0) + 1;
    }

    return Positioned(
      bottom: -12,

      left: isMe ? 0 : null,

      right: isMe ? null : 0,

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(20),

          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: counts.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),

              child: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    Helper.reactionEmoji(entry.key),
                    style: const TextStyle(fontSize: 18),
                  ),

                  if (entry.value > 1)
                    Text(
                      entry.value.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
