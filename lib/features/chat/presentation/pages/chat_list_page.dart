import 'package:chat_app/features/Auth/presentation/bloc/auth_user/auth_user_bloc.dart';
import 'package:chat_app/features/Auth/presentation/bloc/auth_user/auth_user_event.dart';
import 'package:chat_app/features/Auth/presentation/bloc/auth_user/auth_user_state.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_app_bar_widget.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_shimmer_widget.dart';
import 'package:chat_app/features/group/presentation/pages/create_group_page.dart';

import 'package:chat_app/global_widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profile/presentation/pages/profile_page.dart';
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
            BlocListener<AuthUserBloc, AuthUserState>(
              listener: (context, state) {
                if (state.userStatus == UserStatus.success) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return ProfilePage(user: state.userDataEntity!);
                      },
                    ),
                  );
                }

                if (state.userStatus == UserStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error ?? "Error")),
                  );
                }
              },

              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, chatState) {
                  if (chatState.status != ChatStatus.success ||
                      chatState.user == null) {
                    return const SizedBox();
                  }

                  final user = chatState.user!.firstWhere(
                    (element) => element.userId == widget.userId,
                  );

                  return ChatAppBar(
                    title: "Me",
                    desWidget: const Text(
                      "Your Conversations",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    firstIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    twoIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return CreateGroupPage(
                                currentUserId: widget.userId,
                                createdByName: user.title,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    widget: Avatar(
                      avatarUrl: user.avatarUrl,
                      title: user.title,
                      onTap: () {
                        context.read<AuthUserBloc>().add(GetUser());
                      },
                    ),
                  );
                },
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
                    final list = state.user!
                        .where((element) => element.userId != widget.userId)
                        .toList();

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final user = list[index];
                        return ConversationTile(
                          user: user,
                          userId: widget.userId,
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemCount: list.length,
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
