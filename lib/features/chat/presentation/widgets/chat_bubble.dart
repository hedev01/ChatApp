import 'package:flutter/material.dart';
import '../../domain/entities/message_entity.dart';

class ChatBubble extends StatelessWidget {
  final MessageEntity message;
  final String myUserId;
  const ChatBubble({super.key, required this.message, required this.myUserId});

  @override
  Widget build(BuildContext context) {
    final isMe = message.senderId == myUserId;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,

        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 280),

            margin: const EdgeInsets.symmetric(vertical: 8),

            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),

            decoration: BoxDecoration(
              color: isMe ? const Color(0xffF2F2F7) : Colors.black,

              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),

                bottomLeft: Radius.circular(isMe ? 18 : 0),

                bottomRight: Radius.circular(isMe ? 0 : 18),
              ),
            ),

            child: Text(
              message.content,

              style: TextStyle(
                color: isMe ? Colors.black87 : Colors.white,
                fontSize: 16,
              ),
            ),
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
    );
  }
}
