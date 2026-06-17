import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final VoidCallback onTap;
  final String linkText;
  const AuthFooter({super.key, required this.onTap , required this.linkText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Already have an account? ",
        style: const TextStyle(color: Color(0xff323142), fontSize: 16),
        children: [
          TextSpan(
            text: linkText,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
