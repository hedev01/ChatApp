import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class FileMessage extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;

  const FileMessage({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      borderRadius: BorderRadius.circular(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isMe ? Colors.white : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.insert_drive_file,
              size: 28,
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 12),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //message.fileName ??
                  "Unknown File",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isMe ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  //message.fileSize ??
                  "",
                  style: TextStyle(
                    color: isMe ? Colors.grey[700] : Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Icon(Icons.download, color: isMe ? Colors.black54 : Colors.white70),
        ],
      ),
    );
  }
}
