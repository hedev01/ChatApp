import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit_state.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/helper.dart';
import '../../../../locator.dart';
import '../../../Auth/domain/entities/user_entity.dart';
import '../../../Auth/domain/usecases/auth_usecase.dart';
import '../../domain/entities/get_user_entity.dart';
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
            ChatAppBar(
              title: "${widget.chatItem.firstName} ${widget.chatItem.lastName}",
              des: "Online",
              firstIcon: Icons.call,
              twoIcon: Icons.video_call,
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
              onSend: () async {
                chatCubit.send(
                  controller.text,
                  widget.userId,
                  widget.chatItem.userId,
                );
                controller.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
