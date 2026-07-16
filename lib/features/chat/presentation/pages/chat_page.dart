import 'dart:async';

import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit_state.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_app_bar_widget.dart';
import 'package:chat_app/features/chat/presentation/widgets/typing_indicator_widget.dart';
import 'package:chat_app/global_widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/helper.dart';
import '../../../user/domain/entity/get_user_entity.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';

class ChatPage extends StatefulWidget {
  final GetUserDataEntity chatItem;
  final String userId;
  const ChatPage({super.key, required this.chatItem, required this.userId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  late ChatCubit chatCubit;
  Timer? _typingTimer;

  bool _typing = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  init() {
    chatCubit = context.read<ChatCubit>();
    chatCubit.markAsRead(widget.chatItem.userId, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                final isOnline =
                    state.isOnline[widget.chatItem.userId] ?? false;

                final isTyping =
                    state.isTyping[widget.chatItem.userId] ?? false;

                return ChatAppBar(
                  title:
                      "${widget.chatItem.firstName} ${widget.chatItem.lastName}",
                  desWidget: isTyping
                      ? const TypingIndicator(text: "Typing...")
                      : Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isOnline ? Colors.green : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isOnline ? "Online" : "Offline",
                              style: TextStyle(
                                color: isOnline ? Colors.green : Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                  firstIcon: Icons.call,
                  twoIcon: Icons.video_call,
                  widget: Avatar(
                    avatarUrl: widget.chatItem.avatarUrl,
                    firstName: widget.chatItem.firstName,
                    lastName: widget.chatItem.lastName,
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: size.width * .05,
                vertical: size.height * .001,
              ),
              child: Divider(thickness: 0.6),
            ),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  final conversationId = Helper.getConversationId(
                    widget.userId,
                    widget.chatItem.userId,
                  );

                  final messages = state.messages[conversationId] ?? [];

                  print(state.messages.keys);
                  print(conversationId);

                  return ListView.builder(
                    padding: const EdgeInsets.all(18),
                    itemCount: messages.length,
                    itemBuilder: (_, index) {
                      return ChatBubble(
                        message: messages[index],
                        myUserId: widget.userId,
                      );
                    },
                  );
                },
              ),
            ),

            ChatInput(
              controller: controller,
              onChanged: (value) {
                if (!_typing) {
                  _typing = true;

                  context.read<ChatCubit>().startTyping(widget.chatItem.userId);
                }

                _typingTimer?.cancel();

                _typingTimer = Timer(const Duration(seconds: 2), () {
                  _typing = false;

                  context.read<ChatCubit>().stopTyping(widget.chatItem.userId);
                });
              },
              onSend: () async {
                chatCubit.send(
                  controller.text,
                  widget.userId,
                  widget.chatItem.userId,
                );
                controller.clear();

                if (_typing) {
                  _typing = false;

                  _typingTimer?.cancel();

                  context.read<ChatCubit>().stopTyping(widget.chatItem.userId);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_typing) {
      context.read<ChatCubit>().stopTyping(widget.chatItem.userId);
    }

    _typingTimer?.cancel();
    // chatCubit.markAsRead(widget.chatItem.userId, widget.userId);
    super.dispose();
  }
}
