import 'dart:async';
import 'dart:io';

import 'package:chat_app/core/enums/messages_type.dart';
import 'package:chat_app/core/services/upload/picker_repository_imp.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit_state.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_app_bar_widget.dart';
import 'package:chat_app/features/chat/presentation/widgets/typing_indicator_widget.dart';
import 'package:chat_app/features/upload/domain/entity/upload_file_entity.dart';
import 'package:chat_app/features/upload/presentation/bloc/upload_file_bloc.dart';
import 'package:chat_app/features/upload/presentation/bloc/upload_file_event.dart';
import 'package:chat_app/features/upload/presentation/bloc/upload_file_state.dart';
import 'package:chat_app/global_widget/avatar_widget.dart';
import 'package:chat_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/services/upload/picker_repository.dart';
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

            BlocConsumer<UploadFileBloc, UploadFileState>(
              listener: (context, state) {
                if (state.status == UploadFileStatus.success) {
                  final now = DateTime.now();
                  chatCubit.send(
                    MessageEntity(
                      senderId: widget.userId,
                      receiverId: widget.chatItem.userId,
                      content: controller.text,
                      isRead: false,
                      sentAt: now,
                      sentAtTime: Helper.convertDateTimeToTime(
                        now.toIso8601String(),
                      ),
                      fileUrl: state.fileUrl,
                      fileName: state.file!.path.split('/').last,
                      fileSize: state.file!.lengthSync(),
                      type: Helper.getMessageType(state.file!.path),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return ChatInput(
                  controller: controller,
                  onChanged: (value) {
                    if (!_typing) {
                      _typing = true;

                      context.read<ChatCubit>().startTyping(
                        widget.chatItem.userId,
                      );
                    }

                    _typingTimer?.cancel();

                    _typingTimer = Timer(const Duration(seconds: 2), () {
                      _typing = false;

                      context.read<ChatCubit>().stopTyping(
                        widget.chatItem.userId,
                      );
                    });
                  },
                  onSend: () async {
                    final now = DateTime.now();
                    chatCubit.send(
                      MessageEntity(
                        senderId: widget.userId,
                        receiverId: widget.chatItem.userId,
                        content: controller.text,
                        isRead: false,
                        sentAt: now,
                        sentAtTime: Helper.convertDateTimeToTime(
                          now.toIso8601String(),
                        ),
                      ),
                    );
                    controller.clear();

                    if (_typing) {
                      _typing = false;

                      _typingTimer?.cancel();

                      context.read<ChatCubit>().stopTyping(
                        widget.chatItem.userId,
                      );
                    }
                  },
                  onAttach: () async {
                    final repo = locator<PickerRepository>();
                    final file = await repo.pickFile();
                    if (!mounted || file == null) return;
                    context.read<UploadFileBloc>().add(
                      Uploaded(
                        entity: UploadFileEntity(
                          file: File(file.path),
                          userId: widget.userId,
                        ),
                      ),
                    );
                  },
                );
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
