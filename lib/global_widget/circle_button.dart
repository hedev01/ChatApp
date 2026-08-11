
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;
  const CircleButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        icon: icon,
        color: Colors.black87,
        onPressed: onPressed,
      ),
    );
  }
}