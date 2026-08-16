import 'package:chat_app/features/group/presentation/pages/group_chat_page.dart';
import 'package:flutter/material.dart';

class GroupInfoSheet extends StatelessWidget {
  final String groupName;
  final String? groupAvatar;
  final List<GroupMemberMock> members;

  const GroupInfoSheet({
    super.key,
    required this.groupName,
    required this.members,
    this.groupAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
              backgroundImage: groupAvatar != null
                  ? NetworkImage(groupAvatar!)
                  : null,
              child: groupAvatar == null
                  ? Text(
                      groupName[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),

            const SizedBox(height: 12),

            Text(
              groupName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            Text(
              "${members.length} members",
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 20),

            const Divider(),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Members",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(height: 8),

            ...members.map((member) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(
                        member.name[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),

                    if (member.isOnline)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 11,
                          height: 11,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                title: Text(member.name),
                subtitle: Text(member.isOnline ? "Online" : "Offline"),
              );
            }),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
