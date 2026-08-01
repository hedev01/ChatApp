import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/core/enums/messages_type.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class ReplyPreview extends StatelessWidget {
  final MessageEntity replyMessage;
  final String senderName;
  final VoidCallback onCancel;

  const ReplyPreview({
    super.key,
    required this.replyMessage,
    required this.senderName,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  senderName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _getPreviewText(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (replyMessage.type == MessagesType.image &&
              replyMessage.fileUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                Constans.baseUrl + replyMessage.fileUrl!,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),

          const SizedBox(width: 8),

          InkWell(
            onTap: onCancel,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  String _getPreviewText() {
    switch (replyMessage.type) {
      case MessagesType.text:
        return replyMessage.content;

      case MessagesType.image:
        return 'Photo';

      case MessagesType.file:
        return '📎 ${replyMessage.fileName ?? "File"}';
    }
  }
}
