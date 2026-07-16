import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/user/domain/entity/get_user_entity.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.avatarUrl,
    required this.firstName,
    required this.lastName,
    this.onTap
  });

  final String avatarUrl;
  final String firstName , lastName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 28,
        backgroundColor: const Color(0xffEEF4FF),
        backgroundImage: avatarUrl.isNotEmpty
            ? NetworkImage(Constans.baseUrl + avatarUrl)
            : null,
        child: avatarUrl.isEmpty
            ? Text(
                "${firstName.substring(0, 1)}${lastName.substring(0, 1)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xff4F8CFF),
                ),
              )
            : null,
      ),
    );
  }
}