import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit_state.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/features/chat/presentation/widgets/typing_indicator_widget.dart';
import 'package:chat_app/features/group/presentation/cubit/group_cubit.dart';
import 'package:chat_app/features/group/presentation/cubit/group_state.dart';
import 'package:chat_app/features/group/presentation/pages/group_chat_page.dart';
import 'package:chat_app/global_widget/avatar_widget.dart';
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
        if (user.chatType == "Private") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ChatPage(chatItem: user, userId: userId);
              },
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GroupChatPage(
                groupId: user.groupId,
                groupName: user.title,
                currentUserId: userId,
                groupAvatar: user.avatarUrl.isEmpty
                    ? null
                    : Constans.baseUrl + user.avatarUrl,
              ),
            ),
          );
        }
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
                Avatar(avatarUrl: user.avatarUrl, title: user.title),
                if (user.chatType == "Private")
                  BlocBuilder<ChatCubit, ChatCubitState>(
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
                    user.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),
                  BlocBuilder<GroupCubit, GroupState>(
                    builder: (context, groupState) {
                      return BlocBuilder<ChatCubit, ChatCubitState>(
                        builder: (context, chatState) {
                          final lastMessage =
                              chatState.lastMessages[user.userId];
                          final isTyping =
                              chatState.isTyping[user.userId] ?? false;
                          if (user.chatType != "Private") {
                            return Text(
                              groupState.createGroupMessage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.blueGrey.shade700,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
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
                      );
                    },
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BlocBuilder<ChatCubit, ChatCubitState>(
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

                BlocBuilder<ChatCubit, ChatCubitState>(
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
