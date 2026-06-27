import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/conversation_tile_widget.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key, required this.userId});
  final String userId;

  @override
  State<ChatListPage> createState() => _ChatListPageState();

  static Widget _circleButton(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: Colors.black87),
    );
  }
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xffEEF4FF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.smart_toy_rounded,
                      color: Color(0xff4F8CFF),
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Helpy",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Your Conversations",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  ChatListPage._circleButton(Icons.search),
                  const SizedBox(width: 12),
                  ChatListPage._circleButton(Icons.add),

                  const SizedBox(height: 20),
                ],
              ),
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
                        return ConversationTile(user: user);
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
