import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../locator.dart';
import '../../../Auth/domain/entities/user_entity.dart';
import '../../../Auth/domain/usecases/auth_usecase.dart';
import '../../domain/entities/get_user_entity.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';

class ChatPage extends StatefulWidget {
  final GetUserDataEntity chatItem;
  const ChatPage({super.key, required this.chatItem});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  late UserDataEntity currentUser;
  late ChatCubit chatCubit;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    chatCubit = context.read<ChatCubit>();
    final auth = AuthUseCase(locator());

    currentUser = await auth.getUser();

    await chatCubit.connect(currentUser.userId);
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
              child: BlocBuilder<ChatCubit, List<MessageEntity>>(
                builder: (context, messages) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(18),
                    itemCount: messages.length,
                    itemBuilder: (_, index) {
                      return ChatBubble(
                        message: messages[index],
                        myUserId: currentUser.userId,
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
                  currentUser.userId,
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

  @override
  void dispose() {
    chatCubit.stop();
    super.dispose();
  }
}
