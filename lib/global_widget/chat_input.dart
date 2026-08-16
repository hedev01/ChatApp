import 'package:chat_app/global_widget/app_text_field.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback? onAttach;
  final void Function(String)? onChanged;

  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    this.onAttach,
    this.onChanged,
  });

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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onAttach,
                    icon: const Icon(Icons.attach_file),
                  ),
                  Expanded(
                    child: AppTextField(
                      controller: controller,
                      hint: "Write now...",
                      focusedBorder: InputBorder.none,
                      onChanged: onChanged,
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
