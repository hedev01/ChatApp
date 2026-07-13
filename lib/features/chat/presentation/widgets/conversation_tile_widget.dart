import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit_state.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/features/chat/presentation/widgets/typing_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../user/domain/entity/get_user_entity.dart';

class ConversationTile extends StatelessWidget {
  final GetUserDataEntity user;
  final String userId;
  const ConversationTile({super.key, required this.user, required this.userId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ChatPage(chatItem: user, userId: userId);
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xffEEF4FF),
                  backgroundImage: user.avatarUrl.isNotEmpty
                      ? NetworkImage(Constans.baseUrl + user.avatarUrl)
                      : null,
                  child: user.avatarUrl.isEmpty
                      ? Text(
                          "${user.firstName.substring(0, 1)}${user.lastName.substring(0, 1)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff4F8CFF),
                          ),
                        )
                      : null,
                ),

                BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    final isOnlien = state.isOnline[user.userId] ?? false;
                    return Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: isOnlien ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),
                  BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      final lastMessage = state.lastMessages[user.userId];
                      final isTyping = state.isTyping[user.userId] ?? false;
                      if (isTyping) {
                        return TypingIndicator(text: "Typing...");
                      }
                      return Text(
                        lastMessage?.content ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    final sentAt =
                        state.lastMessages[user.userId]?.sentAtTime ?? "";
                    return Text(
                      sentAt,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    final unread = state.unreadCount[user.userId] ?? 0;

                    if (unread == 0) return const SizedBox();

                    return Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xff4F8CFF),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unread.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
