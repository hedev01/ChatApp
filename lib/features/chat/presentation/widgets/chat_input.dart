import 'package:chat_app/global_widget/app_text_field.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInput({super.key, required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),

      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,

            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),

            child: const Icon(Icons.mic, color: Colors.white),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),

              child: Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      hint: "Write Now...",
                      controller: controller,
                      focusedBorder: InputBorder.none,
                    ),
                  ),

                  IconButton(onPressed: onSend, icon: const Icon(Icons.send)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
