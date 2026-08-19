import 'package:chat_app/features/chat/presentation/pages/chat_list_page.dart';
import 'package:chat_app/features/group/presentation/cubit/group_cubit.dart';
import 'package:chat_app/features/group/presentation/widgets/group_info_sheet.dart';
import 'package:chat_app/features/group/presentation/widgets/group_message_bubble.dart';
import 'package:chat_app/global_widget/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String? groupAvatar;
  final String currentUserId;

  const GroupChatPage({
    super.key,
    required this.groupId,
    required this.groupName,
    required this.currentUserId,
    this.groupAvatar,
  });

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  

  final List<GroupMemberMock> members = [
    GroupMemberMock(id: "1", name: "Ali", avatar: null, isOnline: true),
    GroupMemberMock(id: "2", name: "Hossein", avatar: null, isOnline: true),
    GroupMemberMock(id: "3", name: "Mohammad", avatar: null, isOnline: false),
    GroupMemberMock(id: "4", name: "Reza", avatar: null, isOnline: true),
  ];

  

  final List<GroupMessageMock> messages = [
    GroupMessageMock(
      id: "1",
      senderId: "2",
      senderName: "",
      content: "",
      time: "",
    ),
    GroupMessageMock(
      id: "2",
      senderId: "3",
      senderName: "",
      content: "",
      time: "",
    ),
    GroupMessageMock(
      id: "3",
      senderId: "4",
      senderName: "Reza",
      content: "",
      time: "",
    ),
    GroupMessageMock(
      id: "4",
      senderId: "2",
      senderName: "Hossein",
      content: "",
      time: "",
    ),
    GroupMessageMock(
      id: "5",
      senderId: "36d5e373-edad-4c52-b27d-612d0cdc88ed",
      senderName: "Ali",
      content: "",
      time: "",
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  

  void _showGroupInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return GroupInfoSheet(
          groupName: widget.groupName,
          groupAvatar: widget.groupAvatar,
          currentUserId: widget.currentUserId,
        );
      },
    );
  }



  void _deleteGroup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Group"),
          content: const Text("Are you sure you want to delete this group?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await context.read<GroupCubit>().deleteGroup(
                  widget.groupId,
                  widget.groupName,
                );
                Navigator.pop(context);

                // ScaffoldMessenger.of(
                //   this.context,
                // ).showSnackBar(const SnackBar(content: Text("Group deleted)")));
                // Future.delayed(Duration(seconds: 1), () async {
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) {
                //         return ChatListPage(userId: widget.currentUserId);
                //       },
                //     ),
                //   );
                // });
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F9),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),

            const Divider(height: 1, thickness: .6),

            Expanded(child: _buildMessages()),

            _buildInput(),
          ],
        ),
      ),
    );
  }

  

  Widget _buildAppBar() {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          ),

          GestureDetector(
            onTap: _showGroupInfo,
            child: _buildAvatar(widget.groupAvatar, widget.groupName, size: 46),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: GestureDetector(
              onTap: _showGroupInfo,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.groupName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    "${members.length} members",
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),

          IconButton(
            onPressed: _showGroupInfo,
            icon: const Icon(Icons.info_outline),
          ),

          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "delete") {
                _deleteGroup();
              }

              if (value == "members") {
                _showGroupInfo();
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: "members",
                  child: Row(
                    children: [
                      Icon(Icons.people_outline),
                      SizedBox(width: 10),
                      Text("Members"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "delete",
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.red),
                      SizedBox(width: 10),
                      Text("Delete Group", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

  // -----------------------------
  // Messages
  // -----------------------------

  Widget _buildMessages() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];

        final isMe = message.senderId == widget.currentUserId;

        final previous = index > 0 ? messages[index - 1] : null;

        final showSenderName =
            !isMe &&
            (previous == null || previous.senderId != message.senderId);

        return GroupMessageBubble(
          message: message,
          isMe: isMe,
          showSenderName: showSenderName,
        );
      },
    );
  }

  // -----------------------------
  // Input
  // -----------------------------

  Widget _buildInput() {
    return ChatInput(
      controller: _messageController,
      onSend: () {},
      onAttach: () {},
      onChanged: (p0) {},
    );
  }

  Widget _buildAvatar(String? avatar, String name, {double size = 42}) {
    if (avatar != null && avatar.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          avatar,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : "?",
        style: TextStyle(
          color: Colors.white,
          fontSize: size * .4,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// =====================================================
// MOCK MODELS
// =====================================================

class GroupMessageMock {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final String time;

  GroupMessageMock({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.time,
  });
}

class GroupMemberMock {
  final String id;
  final String name;
  final String? avatar;
  final bool isOnline;

  GroupMemberMock({
    required this.id,
    required this.name,
    this.avatar,
    required this.isOnline,
  });
}
