
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  const CircleButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: Colors.black87),
    );
  }
}