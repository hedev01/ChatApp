import 'package:chat_app/core/helper/helper.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chat/presentation/cubit/chat_cubit_state.dart';

class GroupInfoSheet extends StatelessWidget {
  final String groupName;
  final String? groupAvatar;
  final String currentUserId;

  const GroupInfoSheet({
    super.key,
    required this.groupName,
    this.groupAvatar,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state.status != ChatStatus.success || state.user == null) {
          return const SizedBox();
        }
        final list = state.user!
            .where(
              (element) =>
                  element.userId != currentUserId &&
                  element.chatType == "Private",
            )
            .toList();
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black,
                  backgroundImage: groupAvatar != null
                      ? NetworkImage(groupAvatar!)
                      : null,
                  child: groupAvatar == null
                      ? Text(
                          groupName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),

                const SizedBox(height: 12),

                Text(
                  groupName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "${list.length} members",
                  style: TextStyle(color: Colors.grey.shade600),
                ),

                const SizedBox(height: 20),

                const Divider(),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Members",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                ...list.map((member) {
                  return BlocBuilder<ChatCubit, ChatCubitState>(
                    builder: (context, state) {
                      final isOnlien = state.isOnline[member.userId] ?? false;

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Text(
                                Helper.getInitials(member.title[0]),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),

                           
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 11,
                                  height: 11,
                                  decoration:  BoxDecoration(
                                    color: isOnlien ? Colors.green : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        title: Text(member.title),
                        subtitle: Text(isOnlien ? "Online" : "Offline"),
                      );
                    },
                  );
                }),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
