import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool obscure;
  final TextEditingController controller;
  final InputBorder? focusedBorder;
  final void Function(String)? onChanged;

  const AppTextField({
    super.key,
    required this.hint,
    this.icon,
    required this.controller,
    this.focusedBorder,
    this.obscure = false,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        focusedBorder: focusedBorder,
      ),
    );
  }
}
