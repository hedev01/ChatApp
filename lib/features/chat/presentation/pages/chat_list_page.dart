import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_app_bar_widget.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/conversation_tile_widget.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key, required this.userId});
  final String userId;

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    context.read<ChatBloc>().add(ChatSubmitted(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ChatAppBar(
              title: "Me",
              desWidget: Text(
                "Your Conversations",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              firstIcon: Icons.search,
              twoIcon: Icons.add,
            ),
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state.status == ChatStatus.loading) {
                    return ChatShimmer();
                  }
                  if (state.status == ChatStatus.failure) {
                    return Center(child: Text(state.error ?? "Error"));
                  }
                  if (state.status == ChatStatus.success) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final user = state.user![index];
                        return ConversationTile(
                          user: user,
                          userId: widget.userId,
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemCount: state.user!.length,
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
