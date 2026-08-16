import 'dart:io';

import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/core/di/locator.dart';
import 'package:chat_app/core/services/upload/picker_repository.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_list_page.dart';
import 'package:chat_app/features/group/presentation/cubit/group_cubit.dart';
import 'package:chat_app/features/upload/domain/entity/upload_file_entity.dart';
import 'package:chat_app/features/upload/presentation/bloc/upload_file_bloc.dart';
import 'package:chat_app/features/upload/presentation/bloc/upload_file_event.dart';
import 'package:chat_app/features/upload/presentation/bloc/upload_file_state.dart';
import 'package:chat_app/global_widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key, required this.currentUserId});

  final String currentUserId;

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController _groupNameController = TextEditingController();

  final Set<String> _selectedUsers = {};

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  void _toggleUser(String userId) {
    setState(() {
      if (_selectedUsers.contains(userId)) {
        _selectedUsers.remove(userId);
      } else {
        _selectedUsers.add(userId);
      }
    });
  }

  void _createGroup() async {
    final groupName = _groupNameController.text.trim();

    if (groupName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a group name")),
      );
      return;
    }

    if (_selectedUsers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one member")),
      );
      return;
    }

    debugPrint("Group Name: $groupName");
    debugPrint("Avatar: ${context.read<UploadFileBloc>().state.fileUrl}");
    debugPrint("Members: $_selectedUsers");

    await context.read<GroupCubit>().createGroup(
      groupName,
      context.read<UploadFileBloc>().state.fileUrl ?? "",
      _selectedUsers.toList(),
    );

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return ChatListPage(userId: widget.currentUserId);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Group"), centerTitle: true),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state.status == ChatStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ChatStatus.failure) {
            return Center(child: Text(state.error ?? "Error"));
          }

          if (state.status != ChatStatus.success) {
            return const SizedBox();
          }

          final users = state.user!
              .where(
                (user) =>
                    user.userId != widget.currentUserId &&
                    user.chatType == "Private",
              )
              .toList();

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGroupAvatar(),

                      const SizedBox(height: 28),

                      _buildGroupNameField(),

                      const SizedBox(height: 30),

                      _buildMembersHeader(),

                      const SizedBox(height: 12),

                      ...users.map((user) => _buildUserTile(user)),
                    ],
                  ),
                ),
              ),

              _buildCreateButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGroupAvatar() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          final repo = locator<PickerRepository>();
          final file = await repo.pickFile();
          if (!mounted || file == null) return;
          context.read<UploadFileBloc>().add(
            Uploaded(
              entity: UploadFileEntity(
                file: File(file.path),
                userId: widget.currentUserId,
                folderName: "GroupAvatars",
              ),
            ),
          );
        },
        child: Stack(
          children: [
            BlocBuilder<UploadFileBloc, UploadFileState>(
              builder: (context, state) {
                return Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: state.fileUrl != null
                      ? ClipOval(
                          child: Image.network(
                            Constans.baseUrl + state.fileUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.group, size: 48, color: Colors.grey),
                );
              },
            ),

            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupNameField() {
    return TextField(
      controller: _groupNameController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: "Group name",
        hintText: "Enter group name",
        prefixIcon: const Icon(Icons.group_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Widget _buildMembersHeader() {
    return Row(
      children: [
        const Text(
          "Add members",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const Spacer(),

        if (_selectedUsers.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
            child: Text(
              "${_selectedUsers.length} selected",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildUserTile(dynamic user) {
    final isSelected = _selectedUsers.contains(user.userId);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withOpacity(0.08)
            : Colors.transparent,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),

        onTap: () {
          _toggleUser(user.userId);
        },

        leading: Avatar(
          avatarUrl: user.avatarUrl,
          title: user.title,
          onTap: () {},
        ),

        title: Text(
          user.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),

        trailing: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              width: 2,
            ),
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
          child: isSelected
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : null,
        ),
      ),
    );
  }

  Widget _buildCreateButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: _createGroup,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Create Group",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
