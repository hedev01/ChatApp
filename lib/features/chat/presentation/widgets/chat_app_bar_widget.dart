import 'package:chat_app/global_widget/circle_button.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  final String title;
  final Widget desWidget;
  final IconData firstIcon, twoIcon;

  const ChatAppBar({
    super.key,
    required this.title,
    required this.desWidget,
    required this.firstIcon,
    required this.twoIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),

                desWidget,
              ],
            ),
          ),

          CircleButton(icon: firstIcon),
          const SizedBox(width: 12),
          CircleButton(icon: twoIcon),
        ],
      ),
    );
  }
}