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

class ChatBubble extends StatefulWidget {
  final MessageEntity message;
  final List<MessageEntity> allMessages;
  final GetUserDataEntity user;
  final List<MessageReactionEntity> reactions;
  final String myUserId;
  final VoidCallback? onReply;

  const ChatBubble({
    super.key,
    required this.message,
    required this.allMessages,
    required this.user,
    required this.reactions,
    required this.myUserId,
    this.onReply,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _iconOpacityAnimation;

  double _dragExtent = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    final isMe = widget.message.senderId == widget.myUserId;

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(isMe ? -0.2 : 0.2, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _iconOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    _dragExtent = 0;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final isMe = widget.message.senderId == widget.myUserId;

    if ((isMe && details.primaryDelta! < 0) ||
        (!isMe && details.primaryDelta! > 0)) {
      _dragExtent += details.primaryDelta!.abs();

      double progress = (_dragExtent / 100).clamp(0.0, 1.0);
      _controller.value = progress;
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_controller.value > 0.4) {
      if (widget.onReply != null) {
        widget.onReply!();
      }
    }

    _controller.reverse();
    _dragExtent = 0;
  }

  @override
  Widget build(BuildContext context) {
    final isMe = widget.message.senderId == widget.myUserId;

    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      onLongPress: () {
        _showReactionPicker(context);
      },
      child: Container(
        color: Colors.transparent,
        child: Stack(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          children: [
            Positioned(
              right: isMe ? 20 : null,
              left: isMe ? null : 20,
              child: FadeTransition(
                opacity: _iconOpacityAnimation,
                child: Icon(
                  Icons.reply_rounded,
                  color: Colors.grey.shade400,
                  size: 28,
                ),
              ),
            ),

            SlideTransition(
              position: _slideAnimation,
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
                            color: isMe
                                ? const Color(0xffF2F2F7)
                                : Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(18),
                              topRight: const Radius.circular(18),
                              bottomLeft: Radius.circular(isMe ? 18 : 0),
                              bottomRight: Radius.circular(isMe ? 0 : 18),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_getReplyMessage() != null)
                                _buildReplyMessage(_getReplyMessage()!, isMe),

                              _buildMessageContent(isMe, context),
                            ],
                          ),
                        ),
                        if (widget.reactions.isNotEmpty) _buildReactions(isMe),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.message.sentAtTime,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                          if (isMe) ...[
                            const SizedBox(width: 4),
                            Icon(
                              widget.message.isRead
                                  ? Icons.done_all
                                  : Icons.done,
                              size: 15,
                              color: widget.message.isRead
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplyMessage(
  MessageEntity reply,
  bool isMe,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: isMe
          ? Colors.black.withOpacity(0.08)
          : Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(10),
      border: Border(
        left: BorderSide(
          color: Colors.blueAccent,
          width: 3,
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          reply.senderId == widget.myUserId
              ? "You"
              : widget.user.title,
          style: const TextStyle(
            color: Colors.blueAccent,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          _replyPreviewText(reply),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isMe
                ? Colors.black54
                : Colors.white70,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}
String _replyPreviewText(MessageEntity message) {
  switch(message.type) {
    case MessagesType.text:
      return message.content;

    case MessagesType.image:
      return "Photo";

    case MessagesType.file:
      return "📎 ${message.fileName ?? "File"}";
  }
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
                          messageId: widget.message.messageId ?? 0,
                          userId: widget.user.id,
                          senderId: widget.message.senderId,
                          receiverId: widget.message.receiverId,
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
    switch (widget.message.type) {
      case MessagesType.text:
        return Text(
          widget.message.content,
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
                  imageUrl: Constans.baseUrl + widget.message.fileUrl!,
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              Constans.baseUrl + widget.message.fileUrl!,
              width: 220,
              fit: BoxFit.cover,
            ),
          ),
        );

      case MessagesType.file:
        return BlocProvider(
          create: (context) =>
              locator<DownloadCubit>()..check(widget.message.fileName!),
          child: FileMessage(message: widget.message, isMe: isMe),
        );
    }
  }

  Widget _buildReactions(bool isMe) {
    final Map<ReactionType, int> counts = {};

    for (final reaction in widget.reactions) {
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

  MessageEntity? _getReplyMessage() {
    if (widget.message.replyToMessageId == null) {
      return null;
    }

    try {
      return widget.allMessages.firstWhere(
        (element) => element.messageId == widget.message.replyToMessageId,
      );
    } catch (_) {
      return null;
    }
  }
}
