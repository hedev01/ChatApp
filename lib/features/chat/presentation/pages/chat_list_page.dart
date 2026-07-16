import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_app_bar_widget.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_shimmer_widget.dart';
import 'package:chat_app/features/user/domain/usecase/get_user_usecase.dart';
import 'package:chat_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:chat_app/features/user/presentation/bloc/user_event.dart';
import 'package:chat_app/global_widget/avatar_widget.dart';
import 'package:chat_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profile/presentation/pages/profile_page.dart';
import '../../../user/presentation/bloc/user_state.dart';
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
            BlocListener<UserBloc, UserState>(
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

              child: ChatAppBar(
                title: "Me",
                desWidget: Text(
                  "Your Conversations",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                firstIcon: Icons.search,
                twoIcon: Icons.add,
                widget: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state.status == ChatStatus.success) {
                      final user = state.user!.firstWhere(
                        (element) => element.userId == widget.userId,
                      );
                      return Avatar(
                        avatarUrl: user.avatarUrl,
                        firstName: user.firstName,
                        lastName: user.lastName,
                        onTap: () => context.read<UserBloc>().add(GetUser()),
                      );
                    }
                    return SizedBox();
                  },
                ),
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
